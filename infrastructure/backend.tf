terraform {
  backend "s3" {
    bucket         = "your-unique-s3-bucket-name"
    key            = "global/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

