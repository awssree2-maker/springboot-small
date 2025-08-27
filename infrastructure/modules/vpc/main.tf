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
  count      = length(var.my_subnet_cidr)
  vpc_id     = aws_vpc.my_vpc.id
  availability_zone = element(var.azs, count.index)
  cidr_block = var.my_subnet_cidr[count.index]


  tags = {
    Name = "my_public-${count.index + 1}"
  }
}

resource "aws_subnet" "my_private" {
  count      = length(var.my_subnet_cidr)
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.my_subnet_cidr_private[count.index]


  tags = {
    Name = "my_private-${count.index + 1}"
  }
}
# Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Public Route Table
resource "aws_route_table" "my_public_assoction" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Association Public RT -> Public Subnet
resource "aws_route_table_association" "my_public_assoction" {
  count          = length(aws_subnet.my_public)
  subnet_id      = aws_subnet.my_public[count.index].id
  route_table_id = aws_route_table.my_public_assoction.id
}

# Private Route Table (no internet route)


# Association Private RT -> Private Subnet
resource "aws_route_table_association" "private_assoction" {
  count          = length(aws_subnet.my_private)
  subnet_id      = aws_subnet.my_private[count.index].id
  route_table_id = aws_route_table.my_private_assoction.id
}
resource "aws_route_table" "my_private_assoction" {
  vpc_id = aws_vpc.my_vpc.id
}
