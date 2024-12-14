output "lambda_function_name" {
  value = aws_lambda_function.processor.function_name
}

output "sqs_queue_url" {
  value = aws_sqs_queue.lambda_queue.url
}
