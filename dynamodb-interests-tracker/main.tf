provider "aws" {
  region = var.aws_region
}

resource "aws_dynamodb_table" "neighborhood" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = "neighbor"

  attribute {
    name = "neighbor"
    type = "S"
  }

  tags = {
    Environment = var.environment
    Project     = "Neighborhood Tracker"
  }
}

resource "aws_dynamodb_table_item" "neighbor_1" {
  table_name = aws_dynamodb_table.neighborhood.name
  hash_key   = aws_dynamodb_table.neighborhood.hash_key

  item = jsonencode({
    neighbor = { S = "Charlie" }
    pet      = { S = "Golden Retriever" }
    car      = { S = "Red Tesla" }
    funfact  = { S = "Loves gardening" }
    visits_per_month = { N = "4" }
  })
}

resource "aws_dynamodb_table_item" "neighbor_2" {
  table_name = aws_dynamodb_table.neighborhood.name
  hash_key   = aws_dynamodb_table.neighborhood.hash_key

  item = jsonencode({
    neighbor = { S = "cooper" }
    pet      = { S = "Cat" }
    car      = { S = "Blue Honda" }
    visits_per_month = { N = "2" }
  })
}

resource "aws_dynamodb_table_item" "neighbor_3" {
  table_name = aws_dynamodb_table.neighborhood.name
  hash_key   = aws_dynamodb_table.neighborhood.hash_key

  item = jsonencode({
    neighbor = { S = "Sarah" }
    pet      = { S = "Parakeet" }
    car      = { S = "Green Subaru" }
    funfact  = { S = "Makes amazing cookies" }
    hobby    = { S = "Bird watching" }
    visits_per_month = { N = "8" }
  })
}

resource "aws_dynamodb_table_item" "neighbor_4" {
  table_name = aws_dynamodb_table.neighborhood.name
  hash_key   = aws_dynamodb_table.neighborhood.hash_key

  item = jsonencode({
    neighbor = { S = "Mike" }
    car      = { S = "Black Truck" }
    funfact  = { S = "Former chef" }
    visits_per_month = { N = "6" }
  })
}

resource "aws_dynamodb_table_item" "neighbor_5" {
  table_name = aws_dynamodb_table.neighborhood.name
  hash_key   = aws_dynamodb_table.neighborhood.hash_key

  item = jsonencode({
    neighbor = { S = "Emma" }
    pet      = { S = "Labrador" }
    funfact  = { S = "Runs marathons" }
    hobby    = { S = "Photography" }
    visits_per_month = { N = "10" }
  })
}

resource "aws_dynamodb_table_item" "neighbor_6" {
  table_name = aws_dynamodb_table.neighborhood.name
  hash_key   = aws_dynamodb_table.neighborhood.hash_key

  item = jsonencode({
    neighbor = { S = "David" }
    pet      = { S = "German Shepherd" }
    car      = { S = "White Tesla" }
    visits_per_month = { N = "12" }
    favorite_snacks = { L = [
      { S = "Cookies" },
      { S = "Coffee" },
      { S = "Muffins" }
    ] }
    contact_info = { M = {
      phone = { S = "555-0123" }
      email = { S = "david@email.com" }
    } }
  })
}
