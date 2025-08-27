output "ecs_cluster_id" {
  value = aws_ecs_cluster.my_spring_new_cluster.id
}

output "ecs_service_name" {
  value = aws_ecs_service.app.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.app.arn
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.my_ecs_app.name
}
