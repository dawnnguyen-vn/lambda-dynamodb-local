# update lambda function code
awslocal lambda update-function-code \
    --function-name my-lambda \
    --zip-file fileb:///lambda/function.zip

