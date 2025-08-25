variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1" # Mumbai (match your preference)
}

variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
  default     = "springboot-sample"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "container_port" {
  type    = number
  default = 9090
}

variable "desired_count" {
  type    = number
  default = 1
}
variable "bucket_name" {
  description = "yourcompany-terraform-state-ap-south-1"
  type        = string
}

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