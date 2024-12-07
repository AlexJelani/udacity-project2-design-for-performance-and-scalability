# AWS Aurora RDS Exercise

This exercise demonstrates creating an Aurora MySQL cluster with read replicas using Terraform.

## Prerequisites
- AWS CLI configured
- Terraform installed
- Basic understanding of RDS/Aurora

## Components Created
- Aurora MySQL cluster
- Writer instance
- Reader instance (read replica)

## Steps to Execute

1. Update Configuration
   - Edit `main.tf` to set your desired password
   - Adjust instance class if needed (default: db.t3.medium)

2. Initialize Terraform:
```bash
cd terraform
terraform init
