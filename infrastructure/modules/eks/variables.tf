variable "region" { type = string }
variable "cluster_eks_name" { type = string }

variable "vpc" { type = string }

variable "public_subnets" { type = list(string) }
variable "desired_size" { type = number }
variable "max_size" { type = number }
variable "min_size" { type = number }
