# terraform {
#   backend "s3" {
#     bucket         = "springsample-terraform-state-ap-south-1"
#     key            = "global/terraform.tfstate"
#     region         = "ap-south-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }
