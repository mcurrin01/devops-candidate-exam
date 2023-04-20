data "archive_file" "python_lambda_package" {  
  type = "zip"  
  source_file = "${path.module}/code/lambda_requests.py" 
  output_path = "lambda_requests.zip"
}

resource "aws_lambda_function" "lambda_requests" {
        function_name = "lambda_requests"
        filename      = "lambda_requests.zip"
        source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
        role          = "DevOps-Candidate-Lambda-Role"
        runtime       = "python3.7"
        handler       = "lambda_function.lambda_handler"
        timeout       = 10
}

resource "aws_route_table" "example" {
  vpc_id = vpc-00bf0d10a6a41600c
    route {
    cidr_block = "10.0.42.0/24"
    gateway_id = nat-04bad8be564a37c70
    
  }
    tags = {
    Name = "example"
  }
}

