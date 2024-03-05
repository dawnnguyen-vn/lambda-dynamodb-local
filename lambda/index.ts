import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { APIGatewayProxyEvent } from 'aws-lambda';
import { GetItemCommand } from "@aws-sdk/client-dynamodb";

export const handler = async (event: APIGatewayProxyEvent): Promise<any> => {
  const client = new DynamoDBClient({region: 'us-east-1'});
  const command = new GetItemCommand({
    TableName: 'my-dynamodb',
    Key: {
      'id': {S: '1'}
    }
  });

  try {
        const response = await client.send(command);

        const item = response.Item;

        if (item) {
            console.log('Item found:', item);
            return item;
        } else {
            console.log('Item not found');
            return null;
        }
    } catch (error) {
        console.error('Error retrieving item from DynamoDBDDDDD:', error);
        throw error;
    }
};
