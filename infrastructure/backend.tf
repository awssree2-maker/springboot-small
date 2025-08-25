terraform {
  backend "s3" {
    bucket         = "my-tfstate-ap-south-1"
    key            = "global/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
