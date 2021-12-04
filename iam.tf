resource "aws_iam_role" "sample_sns_feedback" {
  for_each = var.main_variables

  name = "sns_feedback_${each.value.name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow",
        Principal = {
          Service = "sns.amazonaws.com"
        }
      }
    ]
  })

  tags       = each.value.tags
}

resource "aws_iam_policy" "sample_sns_feedback" {
  for_each = var.main_variables

  name = "sns_feedback_${each.value.name}"
  description = ""
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:PutMetricFilter",
          "logs:PutRetentionPolicy"
        ]
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })

  tags       = each.value.tags
}

resource "aws_iam_role_policy_attachment" "sample_sns_feedback" {
  for_each = var.main_variables

  role       = aws_iam_role.sample_sns_feedback[each.key].name
  policy_arn = aws_iam_policy.sample_sns_feedback[each.key].arn
}