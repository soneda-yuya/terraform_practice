variable "sample_variables" {
  type = map(any)

  default = {
    oem_dev = {
      name = "hoge1"
      sns = {
        platform = "APNS_VOIP_SANDBOX"
      }
      tags = {
        env = "hoge1"
      }
    }
    oem_fukada = {
      name = "hoge2"
      sns = {
        platform = "APNS_VOIP"
      }
      tags = {
        env = "hoge2"
      }
    }
  }
}

resource "aws_cloudwatch_log_group" "sns_sample" {
  for_each = var.sample_variables

  name = "sns/${each.value.name}"
  tags = each.value.tags
}

// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic
resource "aws_sns_topic" "sns_sample" {
  for_each = var.sample_variables

  fifo_topic = true
  name       = "${each.value.name}.fifo"
  tags       = each.value.tags
}

// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_platform_application
resource "aws_sns_platform_application" "apns_application" {
  for_each = var.sample_variables

  name                = each.value.name
  platform            = each.value.sns.platform
  platform_credential = ""
  platform_principal  = ""
}