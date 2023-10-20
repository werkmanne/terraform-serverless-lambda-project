# create vpc
resource "aws_vpc" "rabbit_mq_vpc" {
  cidr_block           = var.rabbit_vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-${var.environment}-rabbit-mq-vpc"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones_rabbit" {}

# create private subnet az1
resource "aws_subnet" "rabbit_mq_subnet" {
  vpc_id                  = aws_vpc.rabbit_mq_vpc.id
  cidr_block              = var.rabbit_mq_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones_rabbit.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-rabbit-mq-subnet-az-1"
  }
}

# create route table and add public route
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.rabbit_mq_vpc.id

  route {
    cidr_block = var.vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.rabbitMQ_vpc_peer.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-private-route-table"
  }
}

# associate rabbitMQ subnet az1 to "private route table"
resource "aws_route_table_association" "private_subnet_az1_rt_association" {
  subnet_id      = aws_subnet.rabbit_mq_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
