const AWS = require("aws-sdk");
const db = new AWS.DynamoDB.DocumentClient();
const TABLE = "ToDoTable";

exports.handler = async (event) => {
  const method = event.httpMethod;

  if (method === "POST") {
    const task = JSON.parse(event.body).task;
    const item = { id: Date.now().toString(), task };
    await db.put({ TableName: TABLE, Item: item }).promise();
    return { statusCode: 201, body: JSON.stringify(item) };
  }

  if (method === "GET") {
    const result = await db.scan({ TableName: TABLE }).promise();
    return { statusCode: 200, body: JSON.stringify(result.Items) };
  }

  return { statusCode: 400, body: "Unsupported method" };
};
