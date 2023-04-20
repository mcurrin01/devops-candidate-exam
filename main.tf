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
        handler       = "lambda_requests.lambda_handler"
        timeout       = 10

    vpc_config {
    subnet_ids = [aws_subnet.private.id]
    security_group_ids = [aws_default_security_group.default_security_group.id]
  }
}

resource "aws_subnet" "mySubnet" {
  vpc_id                  = data.aws_vpc.vpc.id
  cidr_block              = "10.0.96.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "mySubnet"
  }
}
resource "aws_route_table" "myRouteTable" {
  vpc_id =  data.aws_vpc.vpc.id
     tags = {
    Name = "myRouteTable"
  }
}

resource "aws_route" "myRoute" {

  route_table_id         = aws_route_table.myRouteTable.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = data.aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "myRTA" {

  route_table_id = aws_route_table.myRouteTable.id
  subnet_id      = aws_subnet.mySubnet.id
}

resource "aws_default_security_group" "default_security_group" {
  vpc_id = data.aws_vpc.vpc.id


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "default-security-group"
  }
}





