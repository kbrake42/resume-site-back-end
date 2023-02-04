
resource "aws_dynamodb_table" "table" {

  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "site"

  attribute {
    name = "site"
    type = "S"
  }

  point_in_time_recovery {
    enabled = false
  }

}

resource "aws_dynamodb_table_item" "setup" {
  table_name = aws_dynamodb_table.table.name
  hash_key   = aws_dynamodb_table.table.hash_key

  item = <<ITEM
{
  "site": {"S": "resume"},
  "count": {"S": "0"}
}
ITEM

  lifecycle {
    ignore_changes = [item]
  }

}