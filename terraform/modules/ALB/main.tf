resource "aws_security_group" "alb" {
  name        = "devops-alb-sg-${var.environment}"
  description = "Security group for the application load balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "devops-alb-sg-${var.environment}"
    Environment = var.environment
    Tier        = "load-balancer"
  }
}


resource "aws_lb" "app" {
  name               = "devops-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb.id]
  subnets         = var.public_subnet_ids

  tags = {
    Name        = "devops-alb-${var.environment}"
    Environment = var.environment
    Tier        = "load-balancer"
  }
}


resource "aws_lb_target_group" "app" {
  name     = "devops-tg-${var.environment}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    port                = "8080"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }

  tags = {
    Name        = "devops-tg-${var.environment}"
    Environment = var.environment
    Tier        = "load-balancer"
  }
}


resource "aws_lb_target_group_attachment" "app" {
  count = length(var.target_instance_ids)

  target_group_arn = aws_lb_target_group.app.arn
  target_id        = var.target_instance_ids[count.index]
  port             = 8080
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}