resource "aws_iam_role" "role" {
  name        = "${var.environment}-${var.role_name}"
  description = var.role_description
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = var.trusted_principal
        }
      },
    ]
  })

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
    Module      = "iam_role"
    Name        = "${var.environment}-${var.role_name}"
  }
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  for_each   = var.policy_arns
  role       = aws_iam_role.role.name
  policy_arn = each.value
}