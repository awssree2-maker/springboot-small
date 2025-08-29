resource "aws_eks_cluster" "this" {
  name     = var.cluster_eks_name
  role_arn = aws_iam_role.my_eks_cluster_role.arn
  access_config {
    authentication_mode = "API"
  }


  version = "1.31"
  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids              = concat(var.private_subnets, var.public_subnets)
  }
}



resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_eks_name}-node-group"
  node_role_arn   = aws_iam_role.my_eks_nodes_role.arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
}

