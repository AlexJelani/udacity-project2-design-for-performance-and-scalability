# AWS EC2 Infrastructure with Terraform

This project demonstrates creating AWS EC2 instances using Terraform Infrastructure as Code (IaC).

## Project Structure
aws-ec2-terraform/ ├── main.tf └── README.md



## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed
- AWS account with necessary permissions

## Infrastructure Components

This Terraform configuration creates:
- Multiple EC2 instances in AWS
- Configured in a specified AWS region
- Tagged instances for better resource management

## Usage

1. Initialize Terraform:
```bash
terraform init
