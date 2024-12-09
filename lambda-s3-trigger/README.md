# AWS Lambda S3 Trigger Terraform Project

This project sets up an AWS Lambda function triggered by S3 bucket uploads using Terraform.

## Prerequisites

- AWS CLI configured
- Terraform installed
- Python 3.12 (for Lambda runtime)

## Project Structure
lambda-s3-trigger/ ├── README.md ├── main.tf ├── variables.tf ├── outputs.tf └── src/ └── lambda_function.py


## Setup Instructions

1. Initialize Terraform:
   ```bash
   terraform init
