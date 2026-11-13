output "standard_bucket_name" {
  description = "Name of the standard S3 bucket"
  value       = aws_s3_bucket.standard.bucket
}

output "protected_bucket_name" {
  description = "Name of the protected S3 bucket"
  value       = aws_s3_bucket.protected.bucket
}

output "replacement_dynamodb_name" {
  description = "Name of the replacement DynamoDB table"
  value       = aws_dynamodb_table.replacement.name
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic"
  value       = aws_sns_topic.topic.arn
}

output "lifecycle" {
  description = "lifecycle configurations used"
  value = {
    "prevent_destroy"      = "S3 bucket protected from accidental deletion"
    "create_before_destroy" = "DynamoDB table created before replacing"
    "ignore_changes"       = "SNS Topic ignores changes to Version tag"
  }
}