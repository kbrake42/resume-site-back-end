import json
import boto3
from boto3.dynamodb.conditions import Key, Attr

#always start with the lambda_handler
def lambda_handler(event, context):

    # make the connection to dynamodb
    dynamodb = boto3.resource('dynamodb')

    # select the table
    table = dynamodb.Table("resume-site-table")

    # get item from database
    items = table.get_item(Key={"visitors": 'resume'})
    
    print(json.dumps(items))
    
    
    #response = table.update_item(
    #    Key={'visitors': 'resume'},
    #    UpdateExpression="set item.count = item.count + 1",
    #    #ExpressionAttributeValues={':val': Decimal(str('1'))},
    #    ReturnValues="UPDATED_NEW")

    new_num = int('120') + 1
    new_num = str(new_num)
    print(new_num)
    