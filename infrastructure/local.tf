locals {
  my_cidr                = "10.0.0.0/16"
  my_vpc                 = "spring-vpc"
  my_subnet_cidr         = ["10.0.1.0/24", "10.0.2.0/24"]
  my_subnet_cidr_private = ["10.0.3.0/24", "10.0.4.0/24"]
  bucket_name            = "spring-sfserdff-bucket"
  table_name             = "spring-dev-tfstate"
  my_igw                 = "my_igw_internet"
  ingress_ports          = [80, 8080]
  allowed_cidr           = ["0.0.0.0/0"] # or restrict later
}
