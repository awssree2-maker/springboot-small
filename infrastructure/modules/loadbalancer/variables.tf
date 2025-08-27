variable "alb_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}
variable "allowed_cidr" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}

variable "alb_listener_port" {
  type    = number
  default = 80
}

variable "target_port" {
  type    = number
  default = 8080
}

variable "protocol" {
  type    = string
  default = "HTTP"
}

variable "health_path" {
  type    = string
  default = "/"
}
