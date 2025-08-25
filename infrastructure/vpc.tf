

data "aws_vpc" "existing" {
  id = var.vpc_id
}
# Fetch all subnets in your VPC
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# Then in ECS service
resource "aws_ecs_service" "service" {
  name            = var.cluster_service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.selected.ids
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
}


resource "aws_security_group" "ecs_sg" {
  vpc_id = data.aws_vpc.existing.id
  name   = "ecs-security-group"
  # Inbound and outbound rules
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.cluster_service_task_name
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  requires_compatibilities = ["FARGATE"]

  execution_role_arn = "arn:aws:iam::734842485697:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name   = "springboot-container"
      image  = var.image_id
      cpu    = 256
      memory = 512
      portMappings = [
        {
          containerPort = 8080 # use correct port for your Spring Boot app
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
      essential = true
    }
  ])
}


resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

