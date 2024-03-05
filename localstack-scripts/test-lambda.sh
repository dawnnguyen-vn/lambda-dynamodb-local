# invoke lambda function
awslocal lambda invoke --function-name my-lambda \
    --payload '{"body": "{\"num1\": \"10\", \"num2\": \"10\"}" }' output.txt
