locals {
  my_cidr                = "10.0.0.0/16"
  my_vpc                 = "spring-vpc"
  my_subnet_cidr         = ["10.0.1.0/24", "10.0.2.0/24"]
  my_subnet_cidr_private = ["10.0.3.0/24", "10.0.4.0/24"]
  azs                    = ["ap-south-1a", "ap-south-1b"]
  bucket_name            = "spring-sfserdff-bucket"
  table_name             = "spring-dev-tfstate"
  my_igw                 = "my_igw_internet"
  ingress_ports          = [80, 8080]
  allowed_cidr           = ["0.0.0.0/0"]
  alb_name               = "app-alb-new"
  aws_region             = "ap-south-1"
  #cluster_name           = "my-ecs-fargate-cluster"
  container_image  = "734842485697.dkr.ecr.ap-south-1.amazonaws.com/springboot-sample:latest"
  container_port   = 8080
  task_cpu         = "256"
  task_memory      = "512"
  desired_count    = 2
  cluster_eks_name = "my-eks-cluster"
  node_min         = 2
  node_desired     = 2
  node_max         = 2
}
