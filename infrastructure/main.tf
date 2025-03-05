provider "aws" {
  region = var.aws_region
}

module "network" {
  source     = "./modules/network"
  vpc_cidr   = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
  availability_zone = var.availability_zone
}

module "eks" {
  source         = "./modules/eks"
  cluster_name   = var.cluster_name
  subnet_ids      = module.network.public_subnet_ids  # Control Plane in Public
  node_subnet_ids = module.network.private_subnet_ids # Nodes in Private
  eks_role_name  = var.eks_role_name
  node_role_name = var.node_role_name
  desired_size   = var.desired_size
  min_size       = var.min_size
  max_size       = var.max_size
  admin_iam_arns = var.admin_iam_arns
  vpc_id         = module.network.vpc_id  # Pass the VPC ID
}

module "rds" {
  source        = "./modules/rds"
  db_name       = var.db_name
  db_username   = var.db_username
  db_password   = var.db_password
  subnet_ids = module.network.rds_subnet_ids  # RDS in Separate Private Subnet
  rds_sg_id     = module.security_groups.rds_sg_id
}


module "security_groups" {
  source  = "./modules/security_groups"
  vpc_id  = module.network.vpc_id
}