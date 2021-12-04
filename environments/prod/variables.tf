variable "main_variables" {
  type = map(any)

  default = {
    sample_prod = {
      name = "sample_prod"
      sns = {
        platform = "APNS_SANDBOX"
      }
      tags = {
        env = "sample_prod"
      }
    }
  }
}