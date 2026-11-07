resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

resource "aws_subnet" "public" {
  #   count                   = var.public_subnet_count
  count                   = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  #   count                   = var.private_subnet_count
  count                   = length(var.private_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = false
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public-rt"
  }
}

resource "aws_route_table_association" "public-association" {
  #   count          = var.public_subnet_count
  count          = length(var.public_subnet_cidr_blocks)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public-rt.id
}


resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Private-rt"
  }
}

resource "aws_route_table_association" "private-association" {
  #   count          = var.private_subnet_count
  count          = length(var.private_subnet_cidr_blocks)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_security_group" "sg" {
  # count = var.security_group_count
  count       = length(var.security_groups)
  name        = "${var.security_groups[count.index].name}-sg"
  description = var.security_groups[count.index].description
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = var.security_groups[count.index].ingress_port
    to_port     = var.security_groups[count.index].ingress_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.security_groups[count.index].name}-sg"
  }
}

resource "aws_network_acl" "nacl" {
  count  = 2
  vpc_id = aws_vpc.main.id

  ingress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "nacl-${count.index + 1}"
  }
}

resource "aws_network_acl_association" "public" {
  count          = length(var.public_subnet_cidr_blocks)
  subnet_id      = aws_subnet.public[count.index].id
  network_acl_id = aws_network_acl.nacl[0].id
}

resource "aws_network_acl_association" "private" {
  count          = length(var.private_subnet_cidr_blocks)
  subnet_id      = aws_subnet.private[count.index].id
  network_acl_id = aws_network_acl.nacl[1].id
}

resource "aws_s3_bucket" "bkt" {
  count  = length(var.bucket_names)
  bucket = var.bucket_names[count.index]
  tags = {
    Name = var.bucket_names[count.index]
  }
}