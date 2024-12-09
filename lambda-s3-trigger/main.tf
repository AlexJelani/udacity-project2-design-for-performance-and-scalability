provider "aws" {
  region = var.aws_region
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/src/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "s3_trigger_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "S3_File_Upload_Function"
  role            = aws_iam_role.lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.12"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

# Lambda IAM Role
resource "aws_iam_role" "lambda_role" {
  name = "s3_trigger_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# S3 trigger configuration
resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = aws_s3_bucket.lambda_bucket.id  # Changed from var.s3_bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_trigger_lambda.arn
    events              = ["s3:ObjectCreated:Put"]
  }
  depends_on = [aws_lambda_permission.allow_s3]
}

# Add this to your existing main.tf

# Upload file to S3
resource "aws_s3_object" "test_file" {
  bucket = aws_s3_bucket.lambda_bucket.id  # Changed from var.s3_bucket_name
  key    = "test-upload.txt"
  source = "${path.module}/files/test-upload.txt"
  etag   = filemd5("${path.module}/files/test-upload.txt")
}

# Add after aws_iam_role "lambda_role"
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

# Add before aws_s3_bucket_notification
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_trigger_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.s3_bucket_name}"
}

# Add this before the aws_s3_bucket_notification resource
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.s3_bucket_name
}

# Add bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "lambda_bucket" {
  bucket = aws_s3_bucket.lambda_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Add bucket public access block
resource "aws_s3_bucket_public_access_block" "lambda_bucket" {
  bucket = aws_s3_bucket.lambda_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
