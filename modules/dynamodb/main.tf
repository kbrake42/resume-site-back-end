
resource "aws_dynamodb_table" "table" {

  name           = "site_visitor_counter"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "visitors"

  attribute {
    name = "visitors"
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
  "visitors": {"S": "resume"},
  "count": {"S": "0"}
}
ITEM

  lifecycle {
    ignore_changes = [item]
  }

}