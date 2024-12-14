# AWS Lambda with SQS Trigger using Terraform

This project sets up an AWS Lambda function triggered by an SQS queue using Terraform.

## Prerequisites

- AWS CLI configured
- Terraform installed
- Python 3.x
- AWS Account with appropriate permissions

## Project Structure

## Manual Setup Steps (AWS Console)

1. **Create Lambda Function**:
   - Browse to AWS Lambda Console
   - Click "Create function"
   - Select "Author from scratch"
   - Name your function
   - Select Python runtime
   - Create new execution role with SQS permissions

2. **Configure SQS**:
   - Navigate to SQS Console
   - Create new queue
   - Configure Lambda trigger
   - Test by sending messages

3. **Monitor**:
   - Check CloudWatch logs for function execution

## Terraform Deployment

Now let's create the necessary Terraform files:


mkdir src

1. Initialize Terraform:
   bash
   terraform init
