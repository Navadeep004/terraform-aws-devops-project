resource "aws_security_group" "ec2" {
  name        = "devops-ec2-sg-${var.environment}"
  description = "Security group for DevOps application EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Application traffic from ALB"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "devops-ec2-sg-${var.environment}"
    Environment = var.environment
    Tier        = "application"
  }
}


resource "aws_instance" "app" {
  count = length(var.subnet_ids)

  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = var.subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.ec2.id]

  associate_public_ip_address = false

  user_data = var.user_data

  tags = {
    Name        = "devops-app-server-${count.index + 1}-${var.environment}"
    Environment = var.environment
    Tier        = "application"
  }
}