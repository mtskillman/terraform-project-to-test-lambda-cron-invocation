# I made this interactive for absolutely no reason.
import boto3
from rich import print  # ?
import json
from boto3_type_annotations.dynamodb import Client as DynamoClient

def paginated_scan_given_table(table_name, region):
    all_records = []
    ddb_client: DynamoClient = boto3.client('dynamodb', region_name=region)
    result = ddb_client.scan(
        TableName=table_name,
    )
    all_records.extend(result['Items'])
    while last_evaluated_key := result.get('LastEvaluatedKey'):
        result = ddb_client.scan(
            TableName=table_name,
            ExclusiveStartKey=last_evaluated_key
        )
        all_records.extend(result['Items'])
    return all_records


print('type comma-separated list of regions to scan')
regions = input().split(',')
print('type name of the lag records table')
table_name = input()
print('type name of output file')
output_file_name = input()


final_results = {}
for region in regions:
    print(f'scanning region {region}')
    final_results[region] = paginated_scan_given_table(table_name, region)

with open(output_file_name, 'x') as result_file:
    result_file.write(
        json.dumps(final_results)
    )
print('done.')
