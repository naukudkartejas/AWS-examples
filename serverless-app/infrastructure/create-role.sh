#!/bin/bash
aws iam create-role --role-name lambda-todo-role \
  --assume-role-policy-document file://<(cat <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": { "Service": "lambda.amazonaws.com" },
    "Action": "sts:AssumeRole"
  }]
}
EOF
)

aws iam attach-role-policy --role-name lambda-todo-role \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

aws iam attach-role-policy --role-name lambda-todo-role \
  --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess
