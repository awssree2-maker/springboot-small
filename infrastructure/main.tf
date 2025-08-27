module "myvpc" {
  source                 = "module/vpc"
  my_vpc                 = local.my_vpc
  my_cidr                = local.my_cidr
  my_subnet_cidr         = local.my_subnet_cidr
  my_subnet_cidr_private = local.my_subnet_cidr_private
  my_igw                 = local.my_igw
}
module "s3" {
  source      = "module/s3"
  bucket_name = local.bucket_name
}
module "dyanomdb" {
  source     = "module/dyanmodb"
  table_name = local.table_name
}
module "sg" {
  source        = "module/sg"
  name          = "application-newsg"
  ingress_ports = local.ingress_ports
  allowed_cidr  = local.allowed_cidr
  vpc_id        = module.myvpc
}