provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

resource "aws_s3_bucket" "exercise_bucket" {
  bucket = "udacity-exercise-bucket-${random_id.bucket_suffix.hex}"

  tags = {
    Environment = "Development"
    Project     = "Udacity-Project2"
    Owner       = "YourName"
    Department  = "Learning"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}
