resource "aws_vpc" "my_vpc" {
  cidr_block           = var.my_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.my_vpc
  }
}
