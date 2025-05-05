#!/bin/bash

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION=us-east-1

API_ID=$(aws apigatewayv2 create-api \
  --name "ToDoAPI" \
  --protocol-type HTTP \
  --target arn:aws:lambda:$REGION:$ACCOUNT_ID:function:ToDoFunction \
  --query 'ApiId' --output text)

aws lambda add-permission \
  --function-name ToDoFunction \
  --statement-id apigateway-access \
  --action lambda:InvokeFunction \
  --principal apigateway.amazonaws.com \
  --source-arn arn:aws:execute-api:$REGION:$ACCOUNT_ID:$API_ID/*/*/*

echo "API URL: https://$API_ID.execute-api.$REGION.amazonaws.com"
