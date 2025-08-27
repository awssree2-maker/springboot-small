# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "${var.alb_name}-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  # Allow inbound HTTP (can extend later)
  ingress {
    from_port   = var.alb_listener_port
    to_port     = var.alb_listener_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }
  ingress {
    from_port   = var.listener_port
    to_port     = var.listener_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }


  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.alb_name}-sg"
  }
}

# Application Load Balancer
resource "aws_lb" "new" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnets

  tags = {
    Name = var.alb_name
  }
}

# Target Group
resource "aws_lb_target_group" "this" {
  name        = "${var.alb_name}-tg"
  port        = var.target_port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = "ip" # ECS Fargate → ip, EC2 → instance

  health_check {
    path                = var.health_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "${var.alb_name}-tg"
  }
}

# Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.new.arn
  port              = var.alb_listener_port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

# Outputs
output "alb_dns_name" {
  value = aws_lb.new.name
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.this.arn
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}
