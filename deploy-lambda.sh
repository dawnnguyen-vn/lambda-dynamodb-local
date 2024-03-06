# npm run build --prefix ./lambda
# cp ./lambda/package.json ./lambda/dist
# npm install --prefix ./lambda/dist --omit=dev
# cd ./lambda/dist && zip -r ../function.zip .

# cd lambda && mkdir package
# pip install --target ./package boto3
# cd package && zip -r ../function.zip .
# cd .. && zip function.zip lambda_function.py
# docker exec -it localstack sh -c "sh ./scripts/deploy-lambda.sh"

cd ./lambda && zip function.zip lambda_function.py
docker exec -it localstack sh -c "sh ./scripts/deploy-lambda.sh"
