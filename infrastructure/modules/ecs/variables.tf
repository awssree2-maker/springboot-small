variable "aws_region"     { type = string }
variable "cluster_name"   { type = string }
variable "container_image"{ type = string }
variable "container_port" { type = number }
variable "task_cpu"       { type = string }
variable "task_memory"    { type = string }
variable "desired_count"  { type = number }

# From other modules
variable "public_subnets" { type = list(string) }
variable "sg_id"          { type = string }
variable "target_group_arn" { type = string }
variable "alb_listener"     { type = any }
