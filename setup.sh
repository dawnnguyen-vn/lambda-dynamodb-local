# create mongo db
awslocal dynamodb create-table \
    --table-name phone-data \
    --key-schema AttributeName=phone,KeyType=HASH \
    --attribute-definitions AttributeName=phone,AttributeType=S \
    --billing-mode PAY_PER_REQUEST

# create role for lambda with name 'lambda-get-data'
awslocal iam create-role --role-name lambda-get-data --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}'

# attach dynamodb-full-access policy for lambda role
awslocal iam put-role-policy --role-name lambda-get-data --policy-name dynamodb-full-access --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "dynamodb:*",
            "Resource": "*"
        }
    ]
}'

# create lambda get data function (node) and attach role for lambda
awslocal lambda create-function \
    --function-name get-phone \
    --runtime nodejs18.x \
    --zip-file fileb:///lambda/function.zip \
    --handler index.handler \
    --role arn:aws:iam::000000000000:role/lambda-get-data

# invoke lambda function
awslocal lambda invoke --function-name get-phone \
    --payload '{"body": "{\"num1\": \"10\", \"num2\": \"10\"}" }' output.txt

# update lambda function code
awslocal lambda update-function-code \
    --function-name get-phone \
    --zip-file fileb:///lambda/function.zip

