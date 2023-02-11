output "name" {
  description = "The name of the DynamoDB table"
  value = aws_dynamodb_table.table.name
}

output "hash_key" {
  description = "The hash key of the table"
  value = aws_dynamodb_table.table.hash_key
}

output "arn" {
  description = "The arn of the Table"
  value = aws_dynamodb_table.table.arn
}
