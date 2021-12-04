module "dev" {
  source = "../.."
  main_variables=var.main_variables
  platform_credential=var.platform_credential
  platform_principal=var.platform_principal
}