# hrs-devops-project
This repo is for the assesment for the HRS Group. It contains all the code for Infrastructure, Automation and Application


DevOps Assessment Project

This project demonstrates the deployment of Java-based microservices on AWS using Terraform, Jenkins, and automation scripts. The project is divided into three sections: Infrastructure Setup, CI/CD Pipeline, and Data Export Tool.

1. Infrastructure Setup (Terraform)

The infrastructure is provisioned using Terraform and consists of the following components:

Amazon EKS Cluster: The control plane spans across two public subnets (10.0.1.0/24, 10.0.2.0/24).
EKS Managed Node Group: Nodes are deployed across two private subnets (10.0.3.0/24, 10.0.4.0/24).
Amazon RDS (MySQL): Deployed in a separate private subnet (10.0.5.0/24), ensuring no internet access.
Security Groups:
EKS nodes can communicate with RDS on port 3306.
EKS control plane can manage the nodes via private networking.
Internet access is only available where required (e.g., public-facing ALB).
Networking:
VPC with separate subnets for EKS Control Plane, Node Group, and RDS.
Route tables configured to ensure private subnets can communicate within the VPC.
Key Files:
main.tf - Terraform configuration
variables.tf - Variable definitions
config.tfvars - Configurable values (region, subnet CIDRs, etc.)
outputs.tf - Outputs such as EKS cluster name and subnet IDs
modules/eks, modules/network, modules/rds - Modularized infrastructure setup
2. CI/CD Pipeline (Jenkins)

The Jenkins pipeline automates building, testing, and deploying containerized Java applications to EKS.

Pipeline Steps:
Install Dependencies: Installs Java, Maven, Docker, and AWS CLI if not available.
Checkout Code: Pulls the latest code from GitHub.
Build Application: Uses Maven (mvnw clean package -DskipTests) to package the app.
Build Docker Image: Builds and tags the Docker image.
Push to AWS ECR: Pushes the image to Amazon Elastic Container Registry (ECR).
Deploy to EKS:
Updates kubeconfig for AWS EKS.
Applies Kubernetes manifests (kubectl apply --dry-run=client for validation).
Key File:
Jenkinsfile - Defines the CI/CD pipeline.
3. Data Export Tool (Shell + Python)

A custom tool exports data from Amazon ElastiCache (Redis) and stores it in Amazon S3 as CSV or JSON.

Process:
Extract data from Redis:
Uses redis-cli to dump data.
Converts it to CSV/JSON using Python.
Upload to S3:
Uses AWS CLI (aws s3 cp) to store files in a configured S3 bucket.
Automation:
Can be scheduled via cron or executed in a managed cloud environment.
Key Files:
export_redis.sh - Shell script to extract Redis dump and call Python for processing.
process_data.py - Python script to format and save data as CSV/JSON.
config.env - Stores environment variables (Redis host, S3 bucket name).
Summary:
Infrastructure: Terraform-managed AWS setup with EKS, RDS, and secure networking.
Automation: Jenkins-based CI/CD pipeline for microservices deployment.
Data Processing: Shell/Python-based tool to export Redis data to S3.
This setup ensures scalability, automation, and secure networking for deploying and managing cloud-native applications.


