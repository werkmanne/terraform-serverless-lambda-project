resource "aws_vpc_endpoint" "lambda-function" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.region.lambda"
  vpc_endpoint_type = "Interface"
  subnet_ids         = [aws_subnet.private_subnet_az1.id, aws_subnet.private_subnet_az2.id]

  security_group_ids = [aws_security_group.lambda_vpc_endpoint_security_group.id]

  private_dns_enabled = true
}