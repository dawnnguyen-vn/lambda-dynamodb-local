import boto3

def lambda_handler(event, context):
    client = boto3.client('dynamodb')
    
    response = client.get_item(
        Key={
            '依頼ID': {
                'N': '4660399',
            }
        },
        TableName='autocalling-test',
    )
    print(list(response['Item']['電話番号'].values())[0])
    return "success"
