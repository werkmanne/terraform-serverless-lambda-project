resource "aws_vpc_peering_connection" "rabbitMQ_vpc_peer" {
  peer_vpc_id   = aws_vpc.vpc.id
  vpc_id        = aws_vpc.rabbit_mq_vpc.id
  auto_accept   = true

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc-peering"
  }

   # to ensure proper ordering, it is recommended to add an explicit dependency
  # on the vpc peering for the vpc
  depends_on = [aws_vpc.rabbit_mq_vpc]
}
