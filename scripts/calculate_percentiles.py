import numpy as np
import json
from dateutil import parser

result_file_name = input('type result file name\n')
result_file = open(result_file_name, 'r')
result_as_python = json.load(result_file)

for region in 'us-east-1,us-west-2,eu-west-1,eu-central-1,ap-northeast-1'.split(','):
    relevant_info = [
        (parser.parse(item['time-system']['S']) - parser.parse(item['time-actual']['S'])).seconds
        for item in result_as_python[region]
    ]
    the_max = max(relevant_info)
    for num in (1, 25, 50, 75, 95, 99, 99.9, 99.99, 99.999, 99.9999):
        print(region, num, np.percentile(relevant_info, num))
    print(region, 'MAX', the_max)
