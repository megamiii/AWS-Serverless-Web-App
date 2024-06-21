import json
import boto3

dynamodb = boto3.resource('dynamodb', endpoint_url='http://localhost:4566')
table = dynamodb.Table('WebAppItems')

def lambda_handler(event, context):
    item_id = event['queryStringParameters']['id']
    response = table.get_item(Key={'ID': item_id})
    return {
        'statusCode': 200,
        'body': json.dumps(response.get('Item', {}))
    }