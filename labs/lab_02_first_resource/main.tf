# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "terraform-004-lab-02-vpc"
    Environment = "Development"
    Project     = "terraform-004"
    Managed_By  = "Terraform"
    Owner       = "Sanket"
  }
}