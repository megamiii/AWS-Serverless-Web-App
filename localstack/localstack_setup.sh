#!/bin/bash

# Create DynamoDB table
awslocal dynamodb create-table --table-name WebAppItems \
    --attribute-definitions AttributeName=ID,AttributeType=S \
    --key-schema AttributeName=ID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

# Create and deploy Lambda functions
zip -j /tmp/create_item.zip backend/create_item.py
awslocal lambda create-function --function-name createItem \
    --runtime python3.8 \
    --role arn:aws:iam::000000000000:role/lambda-ex \
    --handler create_item.lambda_handler \
    --zip-file fileb:///tmp/create_item.zip

zip -j /tmp/read_item.zip backend/read_item.py
awslocal lambda create-function --function-name readItem \
    --runtime python3.8 \
    --role arn:aws:iam::000000000000:role/lambda-ex \
    --handler read_item.lambda_handler \
    --zip-file fileb:///tmp/read_item.zip

zip -j /tmp/update_item.zip backend/update_item.py
awslocal lambda create-function --function-name updateItem \
    --runtime python3.8 \
    --role arn:aws:iam::000000000000:role/lambda-ex \
    --handler update_item.lambda_handler \
    --zip-file fileb:///tmp/update_item.zip

zip -j /tmp/delete_item.zip backend/delete_item.py
awslocal lambda create-function --function-name deleteItem \
    --runtime python3.8 \
    --role arn:aws:iam::000000000000:role/lambda-ex \
    --handler delete_item.lambda_handler \
    --zip-file fileb:///tmp/delete_item.zip

# Create the API Gateway
API_ID=$(awslocal apigateway create-rest-api --name "MyAPI" --query 'id' --output text)

# Get the root resource ID
ROOT_ID=$(awslocal apigateway get-resources --rest-api-id $API_ID --query 'items[0].id' --output text)

# Create a resource
RESOURCE_ID=$(awslocal apigateway create-resource --rest-api-id $API_ID --parent-id $ROOT_ID --path-part "{proxy+}" --query 'id' --output text)

# Create a method for the resource
awslocal apigateway put-method --rest-api-id $API_ID --resource-id $RESOURCE_ID --http-method ANY --authorization-type "NONE"

# Set up the integration between API Gateway and Lambda for each function
LAMBDA_FUNCTIONS=("createItem" "readItem" "updateItem" "deleteItem")
for FUNCTION in "${LAMBDA_FUNCTIONS[@]}"
do
    awslocal apigateway put-integration --rest-api-id $API_ID --resource-id $RESOURCE_ID --http-method ANY --type AWS_PROXY --integration-http-method POST --uri "arn:aws:apigateway:local:lambda:path/2015-03-31/functions/arn:aws:lambda:local:000000000000:function:$FUNCTION/invocations"
done

# Deploy the API
awslocal apigateway create-deployment --rest-api-id $API_ID --stage-name local

echo "API ID: $API_ID"