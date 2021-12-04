variable "platform_credential" {}
variable "platform_principal" {}
variable "main_variables" {}

provider "aws" {
  region = "ap-northeast-1"
}

// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic
resource "aws_sns_topic" "sample_sns_topic" {
  for_each = var.main_variables

  fifo_topic = true
  name       = "${each.value.name}.fifo"
  tags       = each.value.tags
}

// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_platform_application
resource "aws_sns_platform_application" "sample_apns_application" {
  for_each = var.main_variables

  name                = each.value.name
  platform            = each.value.sns.platform
  platform_credential = var.platform_credential
  platform_principal  = var.platform_principal
  failure_feedback_role_arn = aws_iam_role.sample_sns_feedback[each.key].arn
  success_feedback_role_arn = aws_iam_role.sample_sns_feedback[each.key].arn
}