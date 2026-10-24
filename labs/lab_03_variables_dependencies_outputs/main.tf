resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "terraform-004-lab-02-vpc"
    Environment = var.environment
    Owner       = "Sanket"
  }
}