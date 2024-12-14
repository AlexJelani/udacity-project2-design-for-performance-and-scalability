provider "aws" {
  region = "us-east-1"
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier     = "aurora-demo-cluster"
  engine                = "aurora-mysql"
  engine_version        = "5.7.mysql_aurora.2.11.2"
  database_name         = "demodb"
  master_username       = "admin"
  master_password       = "your_password_here"
  skip_final_snapshot   = true
  
  tags = {
    Name = "demo-aurora-cluster"
  }
}

resource "aws_rds_cluster_instance" "writer" {
  identifier         = "aurora-demo-writer"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.aurora_cluster.engine
  engine_version     = aws_rds_cluster.aurora_cluster.engine_version
}

resource "aws_rds_cluster_instance" "reader" {
  identifier         = "aurora-demo-reader"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.aurora_cluster.engine
  engine_version     = aws_rds_cluster.aurora_cluster.engine_version
}

output "cluster_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}

output "reader_endpoint" {
  value = aws_rds_cluster.aurora_cluster.reader_endpoint
}
