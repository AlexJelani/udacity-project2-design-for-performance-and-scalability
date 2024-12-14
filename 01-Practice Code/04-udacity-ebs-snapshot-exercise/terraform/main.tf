provider "aws" {
  region = "us-east-1"
}

# EC2 Instance with EBS Volume
resource "aws_instance" "demo" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 20
    volume_type = "gp2"
  }

  tags = {
    Name = "snapshot-demo-instance"
  }
}
# Add this data source to get the EBS volume ID
data "aws_ebs_volume" "ebs_volume" {
  depends_on = [aws_instance.demo]

  filter {
    name   = "attachment.instance-id"
    values = [aws_instance.demo.id]
  }

  filter {
    name   = "attachment.device"
    values = ["/dev/sdf"]
  }
}

# Update the snapshot resource to use the data source
resource "aws_ebs_snapshot" "demo_snapshot" {
  volume_id = data.aws_ebs_volume.ebs_volume.id

  tags = {
    Name = "demo-snapshot"
  }
}
# Output
output "snapshot_id" {
  value = aws_ebs_snapshot.demo_snapshot.id
}
