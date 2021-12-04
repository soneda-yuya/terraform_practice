variable "platform_credential" {
  type = string
}

variable "platform_principal" {
  type = string
}

variable "main_variables" {
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
  }
}