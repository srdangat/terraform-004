data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}


resource "aws_vpc" "development" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "development-vpc"
    Environment = "Development"
    Region      = data.aws_region.current.region
    Account     = data.aws_caller_identity.current.account_id
    CreatedBy   = "${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}"
  }
}

resource "aws_subnet" "development" {
  vpc_id            = aws_vpc.development.id
  cidr_block        = var.subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name        = "development-subnet"
    Environment = "Development"
    AZInfo      = "${data.aws_region.current.region}-${data.aws_availability_zones.available.names[0]}"
  }

}