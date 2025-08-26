resource "aws_vpc" "my_vpc" {
  cidr_block       = var.my_vpc
  instance_tenancy = "default"

  tags = {
    Name = "test"
  }
}
