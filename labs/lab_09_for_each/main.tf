# Main VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main-vpc"
  }
}


resource "aws_subnet" "subnet" {
  for_each          = var.subnet_config
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.subnet_azs[each.key]

  tags = {
    Name = "subnet-${each.key}"
  }
}

resource "aws_route_table" "rt" {
  for_each = var.route_tables
  vpc_id   = aws_vpc.main.id

  tags = {
    Name        = "${each.key}-rt"
    Description = each.value
  }
}

resource "aws_route_table_association" "association" {
  for_each       = var.subnet_config
  route_table_id = aws_route_table.rt[each.key].id
  subnet_id      = aws_subnet.subnet[each.key].id
}

resource "aws_security_group" "sg" {
  for_each    = var.security_group_config
  name        = "${each.key}-sg"
  description = "Security group for ${each.key} servers"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${each.key}-sg"
  }
}

resource "aws_security_group_rule" "ingress" {
  for_each          = var.security_group_config
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg[each.key].id
}

resource "aws_iam_user" "users" {
  for_each = var.iam_users
  name     = each.value
  tags = {
    Name = each.value
  }
}