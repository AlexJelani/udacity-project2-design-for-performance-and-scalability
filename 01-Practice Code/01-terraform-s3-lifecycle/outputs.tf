output "bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.exercise_bucket.id
}

output "bucket_tags" {
  description = "Tags applied to the S3 bucket"
  value       = aws_s3_bucket.exercise_bucket.tags
}