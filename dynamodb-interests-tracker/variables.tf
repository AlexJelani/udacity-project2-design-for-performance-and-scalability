variable "aws_region" {
  description = "AWS region for the DynamoDB table"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment tag value"
  type        = string
  default     = "development"
}

variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "udacity_neighborhood"
}

variable "read_capacity" {
  description = "Read capacity units for the table"
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "Write capacity units for the table"
  type        = number
  default     = 5
}
