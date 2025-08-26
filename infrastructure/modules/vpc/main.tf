resource "aws_vpc" "my_vpc" {
  cidr_block           = var.my_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.my_vpc
  }
}
resource "aws_subnet" "my_public" {
  count = length(var.my_subnet_cidr)
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.my_subnet_cidr


  tags = {
    Name = "my_public-${count.index + 1}"
  }
}

