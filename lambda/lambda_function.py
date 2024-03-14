import boto3

def lambda_handler(event, context):
    client = boto3.client('dynamodb')
    response = client.update_item(
        TableName='autocalling-test',
        Key={
            'request_id': {
                'N': '4452961'
            }
        },
        UpdateExpression='SET #status = :status',
        ExpressionAttributeNames={
            '#status': 'status'
        },
        ExpressionAttributeValues={
            ':status': {
                'S': 'success'
            }
        }
    )
    return "success"
