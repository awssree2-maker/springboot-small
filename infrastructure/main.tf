module "my_vpc" {
  source                 = "./modules/vpc"
  my_vpc                 = local.my_vpc
  my_cidr                = local.my_cidr
  my_subnet_cidr         = local.my_subnet_cidr
  my_subnet_cidr_private = local.my_subnet_cidr_private
  my_igw                 = local.my_igw
}
module "s3" {
  source      = "./modules/s3"
  bucket_name = local.bucket_name
}
module "dyanomdb" {
  source     = "./modules/dyanmodb"
  table_name = local.table_name
}
module "sg" {
  source        = "./modules/sg"
  name          = "application-newsg"
  ingress_ports = local.ingress_ports
  allowed_cidr  = local.allowed_cidr
  vpc_id        = module.my_vpc.vpc_id
}

module "loadbalancer" {
  source         = "./modules/loadbalancer"
  allowed_cidr   = local.allowed_cidr
  vpc_id         = module.my_vpc.vpc_id
  public_subnets = module.my_vpc.my_public
  alb_name       = local.alb_name
  alb_sg_id      = module.loadbalancer.alb_sg_id
}