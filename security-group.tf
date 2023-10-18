# create security group for the bastion host aka jump box
resource "aws_security_group" "bastion_security_group" {
  name        = "${var.project_name}-${var.environment}-ssh-sg"
  description = "enable ssh access on port 22"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.ssh_location]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "${var.project_name}-${var.environment}-ssh-sg"
  }
}

# create security group for the lambda server
resource "aws_security_group" "lambda_security_group" {
  name        = "${var.project_name}-${var.environment}-webserver-sg"
  description = "enable all outbound traffic"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-lambda-sg"
  }
}

# create security group for the database
resource "aws_security_group" "database_security_group" {
  name        = "${var.project_name}-${var.environment}-database-sg"
  description = "enable PostgreSQL access on port 3306 via lambda sg"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "postgreSQL access"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.lambda_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-database-sg"
  }
}


# create security group for the Rabbit MQ
resource "aws_security_group" "rabbit_mq_security_group" {
  name        = "${var.project_name}-${var.environment}-rabbit-sg"
  description = "enable http/https access on port 80/443"
  vpc_id      = aws_vpc.rabbit_mq_vpc.id

  ingress {
    description = "https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-rabbit-mq-sg"
  }
}