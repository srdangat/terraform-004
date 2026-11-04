variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# variable "public_subnet_count" {
#   description = "Number of public subnets to create"
#   type        = number
#   default     = 2
# }

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]

}

# variable "private_subnet_count" {
#   description = "Number of private subnets to create"
#   type        = number
#   default     = 2
# }

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "security_groups" {
  description = "Security group configurations"
  type = list(object({
    name         = string
    description  = string
    ingress_port = number
  }))

  default = [{
    name         = "web"
    description  = "Allow web traffic"
    ingress_port = 80
    },

    {
      name         = "app"
      description  = "Allow app traffic"
      ingress_port = 8080
    },

    {
      name         = "db"
      description  = "Allow db traffic"
      ingress_port = 3306
  }]
}

# variable "security_group_count" {
#   description = "Number of security groups to create"
#   type        = number
#   default     = 3
# }

variable "bucket_names" {
  description = "List of S3 bucket names to create"
  type        = list(string)

  default = [
    "srdangat-demo-001",
    "pdangat-demo-002",
    "rdangat-demo-003"
  ]
}