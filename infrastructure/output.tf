output "alb_dns_name" {
  value       = aws_lb.app.dns_name
  description = "Public URL (http) to reach the app"
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "service_name" {
  value = aws_ecs_service.app.name
}

# output "ecr_repository" {
#   value = aws_ecr_repository.app.name
# }
