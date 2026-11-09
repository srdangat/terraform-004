output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3_bucket.s3_bucket_id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3_bucket.s3_bucket_arn
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}

output "s3_bucket_names" {
  value = {
    for key, bucket in module.s3_buckets :
    key => bucket.s3_bucket_id
  }
}

output "s3_buckets_arn" {
  value = {
    for key, bucket in module.s3_buckets :
    key => bucket.s3_bucket_arn
  }
}