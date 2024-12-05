provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

resource "aws_s3_bucket" "exercise_bucket" {
  bucket = "udacity-exercise-bucket1-c527000"
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


resource "random_id" "bucket_suffix" {
  byte_length = 4
}
