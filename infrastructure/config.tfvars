aws_region = "us-east-1"
vpc_cidr = "10.0.0.0/16"

availability_zones = ["us-east-1a", "us-east-1b"]

public_subnet_cidrs = [
  "10.0.1.0/24",  # EKS Control Plane - Subnet 1
  "10.0.2.0/24"   # EKS Control Plane - Subnet 2
]

private_subnet_cidrs = [
  "10.0.3.0/24",  # EKS Node Group - Subnet 1
  "10.0.4.0/24"   # EKS Node Group - Subnet 2
]

rds_private_subnet_cidrs = [
  "10.0.5.0/24"  # RDS Private Subnet
]

cluster_name = "app-cluster"
eks_role_name = "eksClusterRole"
node_role_name = "eksNodeRole"
desired_size = 2
min_size = 1
max_size = 3
admin_iam_arns = ["arn:aws:iam::123456789012:user/admin"]
db_name = "appdb"
db_username = "admin"
db_password = "securepassword"