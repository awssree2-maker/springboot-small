module "myvpc" {
  source  = "./modules/vpc"
  my_vpc  = local.my_vpc
  my_cidr = local.my_cidr
}
