variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1" # Mumbai (match your preference)
}



variable "vpc_id" {}

variable "cluster_name" {}

variable "cluster_service_name" {}

variable "cluster_service_task_name" {}

variable "image_id" {}

variable "vpc_id_subnet_list" {}

variable "execution_role_arn" {}


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