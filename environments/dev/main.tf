terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.68.0"
    }
  }
}

module "dev" {
  source                = "../.."
  main_variables        = var.main_variables
  platform_credential   = file("./credentials/platform_credential.txt")
  platform_principal    = file("./credentials/platform_principal.txt")
  state_bucket_name     = "terraform-state-sample-dev"
  state_lock_table_name = "terraform_state_lock_table_sample_dev"
}