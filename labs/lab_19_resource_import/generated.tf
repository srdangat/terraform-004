# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# terraform plan -generate-config-out=generated.tf

# __generated__ by Terraform from "sg-0733baa14e2997bfd"
# resource "aws_security_group" "main" {
#   description = "Lab security group"
#   egress = [{
#     cidr_blocks      = ["0.0.0.0/0"]
#     description      = ""
#     from_port        = 0
#     ipv6_cidr_blocks = []
#     prefix_list_ids  = []
#     protocol         = "-1"
#     security_groups  = []
#     self             = false
#     to_port          = 0
#   }]
#   ingress                = []
#   name                   = "lab-web-sg"
#   name_prefix            = null
#   region                 = "us-east-1"
#   revoke_rules_on_delete = null
#   tags = {
#     Environment = "dev"
#     Name        = "lab-web-sg"
#   }
#   tags_all = {
#     Environment = "dev"
#     Name        = "lab-web-sg"
#   }
#   vpc_id = "vpc-046751b28745c9c09"
# }
