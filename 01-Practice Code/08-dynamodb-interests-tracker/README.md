# DynamoDB Interests Tracker

This Terraform project creates and manages a DynamoDB table to store personal interests data.

## Project Structure
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md

## Requirements
- AWS CLI configured
- Terraform installed
- AWS credentials with appropriate permissions

## Resource Details
- DynamoDB table with provisioned capacity
- Partition key: "interest_id" (string)
- Additional attributes for interest tracking

## Capacity Planning
- Read Capacity Units (RCU): 5
- Write Capacity Units (WCU): 5

These values are suitable for:
- Up to 5 strongly consistent reads per second (or 10 eventually consistent reads)
- Up to 5 writes per second
- Item size up to 4KB

## Usage
1. Initialize Terraform:
   
   terraform init
   
