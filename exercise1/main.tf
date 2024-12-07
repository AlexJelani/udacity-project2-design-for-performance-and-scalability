provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

resource "aws_s3_bucket" "exercise_bucket" {
  bucket = "udacity-exercise-bucket1-c527000"
  force_destroy = true
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  bucket = aws_s3_bucket.exercise_bucket.id

  rule {
    id = "media_lifecycle"
    status = "Enabled"

    filter {}

    # After 30 days, move to IA since views decrease
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    # After 90 days, move to Glacier for cold storage
    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    # Delete after 180 days as per requirement
    expiration {
      days = 180
    }
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}
