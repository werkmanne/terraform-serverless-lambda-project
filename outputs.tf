
# rds endpoint
output "rds_endpoint" {
  value = aws_db_instance.database_instance.endpoint
}

output "bastion_host_ec2_ip" {
  value = aws_instance.bastion_host_ec2.public_ip
}

output "rabbitmq_endpoint" {
  value = aws_mq_broker.aws_rabbit_mq.instances.0.console_url
}



