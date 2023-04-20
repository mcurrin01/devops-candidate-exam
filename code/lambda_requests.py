import requests

url = 'https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data'
data = {'subnet_id': 'nat-04bad8be564a37c70', 'name': 'Mark Currin', 'email': 'currin.mark@siemens.com'}
headers = {'X-Siemens-Auth': 'test'}

response = requests.post(url, data=data,headers=headers)

if response.status_code == 200:
    print('Request successful')
else:
    print(f'Request failed with status code {response.status_code}')