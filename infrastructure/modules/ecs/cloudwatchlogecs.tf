resource "aws_cloudwatch_log_group" "my_ecs_app" {
  name              = "/app/ecs/my-spring-app"
  retention_in_days = 7

  tags = {
    Environment = "dev"
    Application = "ecs-fargate"
  }
}

