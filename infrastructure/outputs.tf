output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "private_subnet_id" {
  value = module.network.private_subnet_id
}

output "eks_cluster_id" {
  value = module.eks.cluster_id
}


output "eks_cluster_security_group_id" {
  value = aws_security_group.eks_cluster_sg.id
}

output "eks_nodes_security_group_id" {
  value = aws_security_group.eks_nodes_sg.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}
output "rds_endpoint" {
  value = module.rds.db_endpoint
}