output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_ids" {
  description = "The IDs of the for_each-based subnets"
  value = {
    for key, subnet in aws_subnet.subnet :
    key => subnet.id
  }
}

output "security_group_foreach_ids" {
  description = "The IDs of the for_each-based security groups"
  value = {
    for key, sg in aws_security_group.sg :
    key => sg.id
  }
}

output "route_table_ids" {
  description = "The IDs of the map-based route tables"
  value = {
    for key, rt in aws_route_table.rt :
    key => rt.id
  }
}

output "iam_users" {
  description = "Names of created IAM users"
  value = {
    for key, user in aws_iam_user.users :
    key => user.name
  }
}