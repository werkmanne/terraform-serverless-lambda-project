# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet az1 
resource "aws_eip" "eip1" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-${var.environment}-eip-az-1"
  }
}

# create nat gateway in public subnet az1
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.public_subnet_az1.id

  tags = {
    Name = "${var.project_name}-${var.environment}-ngw-az-1"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  # on the internet gateway for the vpc
  depends_on = [aws_internet_gateway.internet_gateway]
}


# create private route table az1 and add route through nat gateway az1
resource "aws_route_table" "private_route_table_az1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az1.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-privateRT-az-1"
  }
}

# associate private subnet az1 with private route table az1
resource "aws_route_table_association" "private_subnet_az1_rt_az1_association" {
  subnet_id      = aws_subnet.private_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}

# associate private subnet az2 with private route table az1
resource "aws_route_table_association" "private_subnet_az2_rt_az1_association" {
  subnet_id      = aws_subnet.private_subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az1.id
}
