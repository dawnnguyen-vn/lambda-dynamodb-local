# Lambda(Typesctipt) access Dynamodb local setup

## How it work?
1. Run LocalStack

```
docker compose up
```
3. Create DynamoDB, Lambda, and IAM for Lambda can access DynamoDB
- If you don't have function.zip in `lambda` folder, run command below in the root directory
```
touch ./lambda function.zip
```
- In the root directory execute command below

```
sh setup.sh
```
