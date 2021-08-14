# Define Local Values in Terraform
locals {
  origins = var.origins
  environment = var.environment
  name = "${var.origins}-${var.environment}"
  common_tags = {
    owners = local.origins
    environment = local.environment     
  }
}