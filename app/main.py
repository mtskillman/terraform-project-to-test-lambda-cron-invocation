import json
import datetime
import boto3
import os

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ.get('ddb_table_name'))

def handler(event, context):
    now_system_time = datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ")
    now_according_to_event = event['time']

    table.put_item(
        Item={
            'time-actual': now_according_to_event,
            'time-system': now_system_time
        }
    )

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
