# Provider Configuration
provider "aws" {
  region = "us-east-1"
}

# Create key pair
resource "aws_key_pair" "ssh_key" {
  key_name   = "ec2_ssh_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Security Group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from anywhere"
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

# EC2 Instances
resource "aws_instance" "web_server_1" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "WebServer1"
    Environment = "Development"
  }
}

resource "aws_instance" "web_server_2" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "WebServer2"
    Environment = "Development"
  }
}

resource "aws_security_group_rule" "allow_ssh_debug" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_ssh.id
}
