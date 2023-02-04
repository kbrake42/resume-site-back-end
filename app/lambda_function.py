import json
import boto3
from boto3.dynamodb.conditions import Key, Attr
from functions import getCount

#always start with the lambda_handler
def lambda_handler(event, context):

    # make the connection to dynamodb
    dynamodb = boto3.resource('dynamodb')

    # select the table
    table = dynamodb.Table("visitor_counter")

    # get item from database
    items = json.dumps(table.get_item(Key={"site": 'resume'}))
    
    count = getCount(items)
    incrementedCount = str(int(count) + 1)
    print("IncrementedCount= " + incrementedCount)
    
    response = table.update_item(
        Key={'site': "resume"},
        UpdateExpression="SET #count = :c",
        ExpressionAttributeNames= {'#count':'count'},
        ExpressionAttributeValues={':c':incrementedCount},
        ReturnValues="UPDATED_NEW"
        )
    
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Methods": "OPTIONS,POST,GE"
        },
        "body": json.dumps({
            "Visitor": incrementedCount
        })
    }