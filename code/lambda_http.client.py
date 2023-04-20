import http.client
import json

conn = http.client.HTTPSConnection('https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data')

headers = {'Content-type': 'application/json'}
{'X-Siemens-Auth': 'test'}

#desired payload from instructions
payload = {
  "subnet_id": "nat-04bad8be564a37c70",
  "name": "Mark Currin",
  "email": "currin.mark@siemens.com"
}

json_data = json.dumps(payload)

conn.request('POST', '/post', json_data, headers)

response = conn.getresponse()
print(response.read().decode())