# Scripts below will create DynamoDB, Lambda, and IAM role for lambda to access DynamoDB
########################################################################################

# Create DynamoDB
awslocal dynamodb create-table \
    --table-name autocalling-test \
    --key-schema AttributeName=request_id,KeyType=HASH \
    --attribute-definitions AttributeName=request_id,AttributeType=N \
    --billing-mode PAY_PER_REQUEST

# Dump data into DynamoDB
awslocal dynamodb batch-write-item \
    --request-items file:///data/data.json \
    --return-consumed-capacity INDEXES \
    --return-item-collection-metrics SIZE

# Create role for lambda with name 'lambda-role'
awslocal iam create-role --role-name lambda-role --assume-role-policy-document '{
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

# Attach dynamodb-full-access policy for lambda role
awslocal iam put-role-policy --role-name lambda-role --policy-name dynamodb-full-access --policy-document '{
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
    --function-name my-lambda \
    --runtime python3.9 \
    --zip-file fileb:///lambda/function.zip \
    --handler lambda_function.lambda_handler \
    --role arn:aws:iam::000000000000:role/lambda-role
