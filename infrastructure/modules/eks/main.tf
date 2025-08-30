resource "aws_eks_cluster" "this" {
  name     = var.cluster_eks_name
  role_arn = aws_iam_role.my_eks_cluster_role.arn
  access_config {
    authentication_mode = "API"
  }


  version = "1.31"
  vpc_config {
    endpoint_public_access = true
    subnet_ids             = var.public_subnets
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }
}



resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_eks_name}-node-group"
  node_role_arn   = aws_iam_role.my_eks_nodes_role.arn
  subnet_ids      = var.public_subnets
  instance_types  = ["t3.medium"]
  ami_type        = "AL2_x86_64"

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
}

provider "kubernetes" {
  host                   = aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.example.token
}

data "aws_eks_cluster_auth" "example" {
  name = aws_eks_cluster.this.name
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([{
      rolearn  = aws_iam_role.my_eks_nodes_role.arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:bootstrappers", "system:nodes"]
    }])
  }
}
# EKS Addon: VPC CNI
resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = aws_eks_cluster.this.name
  addon_name    = "vpc-cni"
  addon_version = "v1.18.2-eksbuild.1" # check latest version for your region


  tags = {
    Name = "eks-vpc-cni"
  }
}

# EKS Addon: CoreDNS
resource "aws_eks_addon" "coredns" {
  cluster_name  = aws_eks_cluster.this.name
  addon_name    = "coredns"
  addon_version = "v1.11.1-eksbuild.4"

}

# EKS Addon: kube-proxy
resource "aws_eks_addon" "kube_proxy" {
  cluster_name  = aws_eks_cluster.this.name
  addon_name    = "kube-proxy"
  addon_version = "v1.31.0-eksbuild.2"

}

# EKS Addon: EBS CSI driver (for dynamic EBS volumes)
resource "aws_eks_addon" "ebs_csi" {
  cluster_name  = aws_eks_cluster.this.name
  addon_name    = "aws-ebs-csi-driver"
  addon_version = "v1.36.0-eksbuild.1"

}
# -------------------
# Security Groups
# -------------------
resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg"
  description = "Security group for EKS control plane"
  vpc_id      = var.vpc

  # Allow kubectl/API access from your IP
  ingress {
    description = "EKS API access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 👈 replace with your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster-sg"
  }
}

resource "aws_security_group" "eks_node_sg" {
  name        = "eks-node-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc

  # Allow all node-to-node communication
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # Allow inbound traffic for LoadBalancer/NodePort apps
  ingress {
    description = "App traffic"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-node-sg"
  }
}
