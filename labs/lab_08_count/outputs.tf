output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidr_blocks" {
  description = "The CIDR blocks of the private subnets"
  value       = aws_subnet.public[*].cidr_block
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "private_subnet_cidr_blocks" {
  description = "The CIDR blocks of the private subnets"
  value       = aws_subnet.private[*].cidr_block
}

output "security_group_ids" {
  description = "The IDs of the security groups"
  value       = aws_security_group.sg[*].id
}

output "bucket_names" {
  description = "Names of the created S3 buckets"
  value       = aws_s3_bucket.bkt[*].bucket
}