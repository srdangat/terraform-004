resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "standard" {
  bucket = "standard-${var.environment}-${random_string.suffix.result}"
  tags = {
    Name        = "Standard Bucket"
    Environment = var.environment
  }
}

resource "aws_dynamodb_table" "replacement" {
  name         = "replacement-${var.environment}-${random_string.suffix.result}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Id"

  attribute {
    name = "Id"
    type = "S"
  }

  tags = {
    Name        = "Replacement Table"
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket" "protected" {
  bucket = "protected-${var.environment}-${random_string.suffix.result}"
  tags = {
    Name        = "Protected Bucket"
    Environment = var.environment
  }
#   lifecycle {
#     prevent_destroy = true
#   }
}

resource "aws_sns_topic" "topic" {
  name = "test-${var.environment}-${random_string.suffix.result}"
  tags = {
    Name        = "Test Topic"
    Environment = var.environment
    Version     = "2.0.0"
  }

  lifecycle {
    ignore_changes = [
      tags["Version"]
    ]
  }
}