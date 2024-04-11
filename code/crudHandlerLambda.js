const AWS = require('aws-sdk');
AWS.config.update({ region: 'us-east-1' });
const dynamoDb = new AWS.DynamoDB.DocumentClient();
const tableName = 'products';
const healCheckPath = '/health';  
const productPath = '/product';
const productsPath = '/products';


exports.handler = async (event, context, callback) => {
    //remove in prod
    console.log('Received event:', JSON.stringify(event, null, 2));
    switch (true) {

        case event.path === healCheckPath && event.httpMethod === 'GET':
            return buildResponse(200, 'I am healthy');
        case event.path === productPath && event.httpMethod === 'GET':
            return await getProducts(event.QueryStringParameters.prod-id); 
        case event.path === productsPath && event.httpMethod === 'GET':
            return await getProducts();        
        case event.path === productPath && event.httpMethod === 'POST':
            return await createProduct(JSON.parse(event.body));    
        case event.path === productPath && event.httpMethod === 'PATCH':
            const requestBody = JSON.parse(event.body);
            return await updateProduct(requestBody.prodId, requestBody.updateKey, requestBody.updateValue);
        case event.path === productPath && event.httpMethod === 'DELETE':
            return await deleteProduct(JSON.parse(event.body).prodId);    
    }
}

async function updateProduct(prodId, updateKey, updateValue) {
    const params = {
        TableName: tableName,
        Key: {
            'prodId': prodId
        },
        UpdateExpression: `set ${updateKey} = :updateValue`,
        ExpressionAttributeValues: {
            ':updateValue': updateValue
        },
        ReturnValues: 'UPDATED_NEW'
    };

    return await dynamoDb.update(params).promise()
        .then(data => {
            return buildResponse(200, data.Attributes);
        })
        .catch(err => {
            console.log(err);
            return buildResponse(500, err);
        });

}

async function deleteProduct(prodId) {
    const params = {
        TableName: tableName,
        Key: {
            'prodId': prodId
        }
    };

    return await dynamoDb.delete(params).promise()
        .then(() => {
            return buildResponse(204, {});
        })
        .catch(err => {
            console.log(err);
            return buildResponse(500, err);
        });
}

async function createProduct(product) {
    const params = {
        TableName: tableName,
        Item: product
    };

    return await dynamoDb.put(params).promise()
        .then(() => {
            return buildResponse(201, product);
        })
        .catch(err => {
            console.log(err);
            return buildResponse(500, err);
        });
}

async function getProducts(prodId) {
    const params = {
        TableName: tableName,
        Key: {
            'prodId': prodId
        }
    };

    if (prodId === undefined) {
        return await dynamoDb.scan({ TableName: tableName }).promise()
            .then(data => {
                return buildResponse(200, data.Items);
            })
            .catch(err => {
                console.log(err);
                return buildResponse(500, err);
            });
    }

    return await dynamoDb.get(params).promise()
        .then(data => {
            return buildResponse(200, data.Item);
        })
        .catch(err => {
            console.log(err);
            return buildResponse(500, err);
        });
}


function buildResponse(statusCode, body) {
    return {
        statusCode: statusCode,
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(body)
    }
}