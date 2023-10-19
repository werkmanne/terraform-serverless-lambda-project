resource "aws_key_pair" "bastion_keypair" {
  key_name   = var.rabbitmq_keypair
  public_key = var.public_execution_key
}

resource "aws_instance" "bastion_host_ec2" {
  ami                    = var.amazon_linux_ami_id
  instance_type          = var.instance_type_name
  subnet_id              = aws_subnet.public_subnet_az1.id
  vpc_security_group_ids = [aws_security_group.bastion_security_group.id]
  key_name               = var.rabbitmq_keypair

  depends_on = [aws_key_pair.bastion_keypair]

  tags = {
    Name = "${var.project_name}-${var.environment}-ec2-bastion"
  }
}

