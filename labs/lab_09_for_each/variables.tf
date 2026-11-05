variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "subnet_config" {
  description = "Map of subnet configurations"
  type        = map(string)
  default = {
    "public"   = "10.0.10.0/24"
    "private1" = "10.0.20.0/24"
    "private2" = "10.0.30.0/24"
  }
}

variable "subnet_azs" {
  description = "Map of subnet availability zones"
  type        = map(string)
  default = {
    "public"   = "us-east-1a"
    "private1" = "us-east-1b"
    "private2" = "us-east-1c"
  }
}

variable "security_group_config" {
  description = "Map of security group ports"
  type        = map(number)
  default = {
    "web"   = 80
    "app"   = "8080"
    "db"    = "3306"
    "redis" = "6379"
  }
}

variable "route_tables" {
  description = "Map of route tables to create"
  type        = map(string)
  default = {
    "public"   = "Public route table"
    "private1" = "Private route table 1"
    "private2" = "Private route table 2"
  }
}

variable "iam_users" {
  description = "IAM users to create"
  type        = set(string)
  default     = ["admin", "developer", "tester"]
}