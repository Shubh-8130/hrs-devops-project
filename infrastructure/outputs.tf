output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "eks_cluster_id" {
  value = module.eks.cluster_id
}