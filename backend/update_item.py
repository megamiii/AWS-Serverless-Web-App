import json
import boto3

dynamodb = boto3.resource('dynamodb', endpoint_url='http://localhost:4566')
table = dynamodb.Table('WebAppItems')

def lambda_handler(event, context):
    item = json.loads(event['body'])
    table.update_item(
        Key={'ID': item['ID']},
        UpdateExpression="set info=:i",
        ExpressionAttributeValues={':i': item['info']},
        ReturnValues="UPDATED_NEW"
    )
    return {
        'statusCode': 200,
        'body': json.dumps({'message': 'Item updated successfully'})
    }