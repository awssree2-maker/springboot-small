variable "my_vpc" {
  description = "springboot-vpc"
  type        = string
}

variable "my_cidr" {
  type = string
}
variable "azs" {
  type = list(string)
}

variable "my_subnet_cidr" {
  type = list(string)
}

variable "my_subnet_cidr_private" {
  type = list(string)
}
variable "my_igw" {
  type = string
}