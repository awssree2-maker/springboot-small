terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket         = "spring-s3-bucket"   # same as locals
    key            = "spring/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "spring-dyanodb"
    encrypt        = true
  }
}
