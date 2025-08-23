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
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "container_port" {
  type        = number
  default     = 8080
}

variable "desired_count" {
  type        = number
  default     = 1
}
