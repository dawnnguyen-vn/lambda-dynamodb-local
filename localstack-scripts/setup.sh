# # Scripts below will create DynamoDB, Lambda, and IAM role for lambda to access DynamoDB
# ########################################################################################

# # Create DynamoDB
# awslocal dynamodb create-table \
#     --table-name my-dynamodb \
#     --key-schema AttributeName=id,KeyType=HASH \
#     --attribute-definitions AttributeName=id,AttributeType=S \
#     --billing-mode PAY_PER_REQUEST

# # Create role for lambda with name 'lambda-role'
# awslocal iam create-role --role-name lambda-role --assume-role-policy-document '{
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Principal": {
#                 "Service": "lambda.amazonaws.com"
#             },
#             "Action": "sts:AssumeRole"
#         }
#     ]
# }'

# # Attach dynamodb-full-access policy for lambda role
# awslocal iam put-role-policy --role-name lambda-role --policy-name dynamodb-full-access --policy-document '{
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": "dynamodb:*",
#             "Resource": "*"
#         }
#     ]
# }'

# create lambda get data function (node) and attach role for lambda
awslocal lambda create-function \
    --function-name my-lambda \
    --runtime nodejs18.x \
    --zip-file fileb:///lambda/function.zip \
    --handler index.handler \
    --role arn:aws:iam::000000000000:role/lambda-role
