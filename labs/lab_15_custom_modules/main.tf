# module "s3_read_only_policy" {
#   source             = "./modules/iam_policy"
#   environment        = var.environment
#   policy_name        = "s3-read-only"
#   policy_description = "Allow read-only access to S3"
#   policy_statements = [{
#     effect    = "Allow"
#     actions   = ["s3:Get*", "s3:List*"]
#     resources = ["*"]
#   }]
# }

# module "cloudwatch_write_policy" {
#   source             = "./modules/iam_policy"
#   environment        = var.environment
#   policy_name        = "cloudwatch-write"
#   policy_description = "Allow Cloudwatch write access"
#   policy_statements = [{
#     effect    = "Allow"
#     actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
#     resources = ["*"]
#   }]
# }

moved {
  from = module.s3_read_only_policy
  to   = module.polices["s3-read-only"]
}

moved {
  from = module.cloudwatch_write_policy
  to   = module.polices["cloudwatch-write"]
}

module "polices" {
  source             = "./modules/iam_policy"
  for_each           = var.polices
  environment        = var.environment
  policy_name        = each.key
  policy_description = each.value.description
  policy_statements  = each.value.statements
}

module "app_role" {
  source            = "./modules/iam_roles"
  environment       = var.environment
  role_name         = "app-role"
  role_description  = "Application role"
  trusted_principal = "ec2.amazonaws.com"
  policy_arns = {
    s3_read_only = module.polices["s3-read-only"].policy_arn
  }
}

module "monitoring_role" {
  source            = "./modules/iam_roles"
  environment       = var.environment
  role_name         = "monitoring-role"
  role_description  = "Monitoring role"
  trusted_principal = "lambda.amazonaws.com"
  policy_arns = {
    cloudwatch_write = module.polices["cloudwatch-write"].policy_arn
  }
}