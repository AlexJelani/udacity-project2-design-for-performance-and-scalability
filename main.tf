resource "aws_s3_bucket" "exercise_bucket" {
  bucket = "udacity-exercise-bucket1-c527000"
  force_destroy = true
}
