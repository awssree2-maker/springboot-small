# Get caller identity (who is running Terraform)
data "aws_caller_identity" "current" {}

# Get region
data "aws_region" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "region" {
  value = data.aws_region.current.name
}

module "my_vpc" {
  source                 = "./modules/vpc"
  my_vpc                 = local.my_vpc
  my_cidr                = local.my_cidr
  my_subnet_cidr         = local.my_subnet_cidr
  my_subnet_cidr_private = local.my_subnet_cidr_private
  my_igw                 = local.my_igw
  azs                    = local.azs
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
  public_subnets = module.my_vpc.my_public_subnet_ids
  alb_name       = local.alb_name
  alb_sg_id      = module.loadbalancer.alb_sg_id
}
# module "ecs" {
#   source           = "./modules/ecs"
#   alb_listener     = module.loadbalancer.alb_sg_id
#   aws_region       = local.aws_region
#   cluster_name     = local.cluster_name
#   container_image  = local.container_image
#   container_port   = local.container_port
#   desired_count    = local.desired_count
#   public_subnets   = module.my_vpc.my_public_subnet_ids
#   sg_id            = module.loadbalancer.alb_sg_id
#   target_group_arn = module.loadbalancer.alb_target_group_arn
#   task_cpu         = local.task_cpu
#   task_memory      = local.task_memory
# }


module "eks" {
  source           = "./modules/eks"
  public_subnets   = module.my_vpc.my_public_subnet_ids
  cluster_eks_name = local.cluster_eks_name
  desired_size     = local.node_desired
  max_size         = local.node_max
  min_size         = local.node_min
  private_subnets  = module.my_vpc.my_private_subnet_ids
  region           = local.aws_region
}