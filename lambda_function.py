import json
import boto3
from boto3.dynamodb.conditions import Key, Attr

#Branch - Test
#always start with the lambda_handler
def lambda_handler(event, context):

    #Get the count from the database item
    def getCount(dbItem):
        json_tree = json.loads(dbItem)
        item = json_tree['Item']
        return (item['count'])

    # make the connection to dynamodb -- new text
    dynamodb = boto3.resource('dynamodb')

    # select the table
    table = dynamodb.Table("resume-site-table")

    # get item from database
    items = json.dumps(table.get_item(Key={"visitors": 'resume'}))
    
    count = getCount(items)
    incrementedCount = str(int(count) + 1)
    print("IncrementedCount= " + incrementedCount)
    
    response = table.update_item(
        Key={'visitors': "resume"},
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