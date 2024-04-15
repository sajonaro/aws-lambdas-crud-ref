resource "aws_dynamodb_table" "product_table" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "prodId"

  attribute {
    name = "prodId"
    type = "S"
  }
}