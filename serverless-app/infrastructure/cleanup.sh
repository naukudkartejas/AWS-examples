#!/bin/bash

echo "Fetching API ID..."
API_ID=$(aws apigatewayv2 get-apis --query "Items[?Name=='ToDoAPI'].ApiId" --output text)
if [ -n "$API_ID" ]; then
  aws apigatewayv2 delete-api --api-id $API_ID
  echo "Deleted API Gateway with ID: $API_ID"
fi

# Delete Lambda Function
aws lambda delete-function --function-name ToDoFunction
echo "Deleted Lambda function"

# Delete DynamoDB Table
aws dynamodb delete-table --table-name ToDoTable
echo "Deleted DynamoDB table"

# Detach and delete IAM role
aws iam detach-role-policy --role-name lambda-todo-role \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

aws iam detach-role-policy --role-name lambda-todo-role \
  --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess

aws iam delete-role --role-name lambda-todo-role
echo "Deleted IAM role"
