data "archive_file" "python_lambda_package" {  
  type = "zip"  
  source_file = "${path.module}/code/lambda_requests.py" 
  output_path = "lambda_requests.zip"
}

resource "aws_lambda_function" "lambda_requests" {
        function_name = "lambda_requests"
        filename      = "lambda_requests.zip"
        source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
        role          = data.aws_iam_role.lambda.arn
        runtime       = "python3.7"
        handler       = "lambda_function.lambda_handler"
        timeout       = 10
}

resource "aws_route_table" "example" {
  vpc_id =  data.aws_vpc.vpc.id
    route {
    cidr_block = "10.0.42.0/24"
    gateway_id = data.aws_nat_gateway.nat.id
    
  }
    tags = {
    Name = "example"
  }
}

