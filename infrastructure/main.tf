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
  subnet_ids     = [module.network.public_subnet_id]
  eks_role_name  = var.eks_role_name
  node_role_name = var.node_role_name
  desired_size   = var.desired_size
  min_size       = var.min_size
  max_size       = var.max_size
}