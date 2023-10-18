resource "aws_mq_broker" "aws_rabbit_mq" {
  broker_name = var.rabbitmq_broker
  subnet_ids = [aws_subnet.rabbit_mq_subnet.id]
  deployment_mode = var.rabbitmq_deployment

  engine_type        = var.rabbitmq_engine_type
  engine_version     = var.rabbitmq_engine_version
  host_instance_type = var.rabbitmq_instance_type
  security_groups    = [aws_security_group.rabbit_mq_security_group.id]

  user {
    username = local.secrets.username
    password = local.secrets.password
  }
}
