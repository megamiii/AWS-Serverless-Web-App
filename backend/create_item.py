import json
import boto3

dynamodb = boto3.resource('dynamodb', endpoint_url='http://localhost:4566')
table = dynamodb.Table('WebAppItems')

def lambda_handler(event, context):
    item = json.loads(event['body'])
    table.put_item(Item=item)
    return {
        'statusCode': 200,
        'body': json.dumps({'message': 'Item created successfully'})
    }