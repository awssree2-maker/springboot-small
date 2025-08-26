module "myvpc" {
  source                 = "./modules/vpc"
  my_vpc                 = local.my_vpc
  my_cidr                = local.my_cidr
  my_subnet_cidr         = local.my_subnet_cidr
  my_subnet_cidr_private = local.my_subnet_cidr_private
}
