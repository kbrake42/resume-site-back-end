import json
response = '{"Item": {"count": "3", "visitors": "resume"}, "ResponseMetadata": {"RequestId": "1PIO2HQJ6SC25TL3F2FJ5HDR0FVV4KQNSO5AEMVJF66Q9ASUAAJG", "HTTPStatusCode": 200, "HTTPHeaders": {"server": "Server", "date": "Wed, 28 Sep 2022 20:06:14 GMT", "content-type": "application/x-amz-json-1.0", "content-length": "54", "connection": "keep-alive", "x-amzn-requestid": "1PIO2HQJ6SC25TL3F2FJ5HDR0FVV4KQNSO5AEMVJF66Q9ASUAAJG", "x-amz-crc32": "378883206"}, "RetryAttempts": 0}}'

def transactions():
    json_tree = json.loads(response)
    item = json_tree['Item']
    return (item['count'])

count = transactions()
print('The item count is ' + count)

count = int(count)

print(type(count))
