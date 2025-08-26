locals {
  my_cidr                = "10.0.0.0/16"
  my_vpc                 = "spring-vpc"
  my_subnet_cidr         = ["10.0.1.0/24", "10.0.2.0/24"]
  my_subnet_cidr_private = ["10.0.3.0/24", "10.0.4.0/24"]
  bucket_name            = "spring-s3-bucket"
  table_name             = "spring-sfsef-tfstate"
  aws_region             = "ap-south-1"
}
