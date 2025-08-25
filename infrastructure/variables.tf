variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1" # Mumbai (match your preference)
}



# VPC where ECS will runnn
variable "vpc_id" {
  description = "The ID of the VPC where ECS resources will be deployed"
  type        = string
}

# ECS Cluster name
variable "cluster_name" {
  description = "Name of the ECS Cluster"
  type        = string
}

# ECS Service name
variable "cluster_service_name" {
  description = "Name of the ECS Service that runs tasks"
  type        = string
}

# ECS Task Definition family name
variable "cluster_service_task_name" {
  description = "Name of the ECS Task Definition"
  type        = string
}

# ECR image for your container
variable "image_id" {
  description = "ECR image URI for the container (e.g., <account>.dkr.ecr.<region>.amazonaws.com/repo:tag)"
  type        = string
}

# Subnets in the VPC for ECS tasks
variable "vpc_id_subnet_list" {
  description = "List of subnet IDs in the VPC where ECS tasks should run"
  type        = list(string)
}

# IAM execution role ARN for ECS
# variable "execution_role_arn" {
#   description = "ARN of the ECS execution role used to pull images and send logs"
#   type        = string
# }


variable "dynamodb_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
  default     = "terraform-locks"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    Project = "terraform-state"
    Owner   = "devops"
  }
}