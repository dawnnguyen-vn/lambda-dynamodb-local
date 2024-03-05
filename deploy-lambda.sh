npm run build --prefix ./lambda
cp ./lambda/package.json ./lambda/dist
npm install --prefix ./lambda/dist --omit=dev
cd ./lambda/dist && zip -r ../function.zip .
docker exec -it localstack sh -c "sh ./scripts/deploy-lambda.sh"
