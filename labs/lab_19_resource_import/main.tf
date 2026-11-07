resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "${var.prefix}-vpc"
    Environment = var.environment
  }
}

import {
  to = aws_subnet.app
  id = "subnet-0745c972cfcba1712"
}

resource "aws_subnet" "app" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr
  tags = {
    Name        = "${var.prefix}-subnet"
    Environment = var.environment
  }
}

import {
  to = aws_security_group.main
  id = "sg-0733baa14e2997bfd"
}

resource "aws_security_group" "main" {
  name        = "${var.prefix}-web-sg"
  description = "Lab security group"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name        = "${var.prefix}-web-sg"
    Environment = var.environment
  }
}