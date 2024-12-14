provider "aws" {
  region = "us-east-1"  # Fixed to us-east-1
}

# VPC and Subnet (using default for this exercise)
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security Group for EC2
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for EFS
resource "aws_security_group" "efs_sg" {
  name        = "efs-sg"
  description = "Security group for EFS mount targets"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }
}

# EC2 Instance
resource "aws_instance" "demo" {
  ami           = "ami-0230bd60aa48260c6"  # Amazon Linux 2023 AMI in us-east-1
  instance_type = "t2.micro"

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  # Additional EBS volume
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 20
    volume_type = "gp2"
  }

  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "storage-demo-instance"
  }
}

# EFS File System
resource "aws_efs_file_system" "demo" {
  creation_token = "demo-efs"
  
  tags = {
    Name = "demo-efs"
  }
}

# EFS Mount Targets
resource "aws_efs_mount_target" "demo" {
  count           = length(data.aws_subnets.default.ids)
  file_system_id  = aws_efs_file_system.demo.id
  subnet_id       = data.aws_subnets.default.ids[count.index]
  security_groups = [aws_security_group.efs_sg.id]
}

# Outputs
output "instance_id" {
  value = aws_instance.demo.id
}

output "efs_id" {
  value = aws_efs_file_system.demo.id
}
