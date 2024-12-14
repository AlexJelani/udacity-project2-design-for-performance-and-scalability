output "table_name" {
  description = "Name of the created DynamoDB table"
  value       = aws_dynamodb_table.neighborhood.name
}

output "table_arn" {
  description = "ARN of the created DynamoDB table"
  value       = aws_dynamodb_table.neighborhood.arn
}

output "table_id" {
  description = "ID of the created DynamoDB table"
  value       = aws_dynamodb_table.neighborhood.id
}

output "neighbor_count" {
  description = "Number of neighbors in the table"
  value       = length([
    aws_dynamodb_table_item.neighbor_1,
    aws_dynamodb_table_item.neighbor_2,
    aws_dynamodb_table_item.neighbor_3,
    aws_dynamodb_table_item.neighbor_4,
    aws_dynamodb_table_item.neighbor_5,
    aws_dynamodb_table_item.neighbor_6
  ])
}
