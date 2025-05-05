#!/bin/bash

cd lambda
zip -r ../function.zip .
cd ..

ROLE_ARN=$(aws iam get-role --role-name lambda-todo-role --query 'Role.Arn' --output text)

aws lambda create-function \
  --function-name ToDoFunction \
  --runtime nodejs18.x \
  --handler index.handler \
  --role $ROLE_ARN \
  --zip-file fileb://function.zip
