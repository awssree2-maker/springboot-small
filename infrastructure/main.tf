module "myvpc" {
  source = "./modules/vpc"
  my_vpc = local.my_vpc
}
