variable "main_variables" {
  type = map(any)

  default = {
    sample_dev = {
      name = "sample_dev"
      sns = {
        platform = "APNS_VOIP_SANDBOX"
      }
      tags = {
        env = "sample_dev"
      }
    }
  }
}