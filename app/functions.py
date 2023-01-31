import json

def getCount(dbItem):
        json_tree = json.loads(dbItem)
        item = json_tree['Item']
        return (item['count'])
     