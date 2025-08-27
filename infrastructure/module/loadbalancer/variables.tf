variable "name" {
  type = string
}

# variable "vpc_id" {
#   type = string
# }

variable "ingress_ports" {
  type = list(number)
}

variable "allowed_cidr" {
  type = list(string)
}
