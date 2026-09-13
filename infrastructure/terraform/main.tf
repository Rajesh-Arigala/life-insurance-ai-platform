locals {
  resource_group_name = "rg-${var.project_code}-${var.environment}-${var.region_code}-${var.instance}"

  key_vault_name = "kv-${var.project_code}-${var.environment}-${var.region_code}-${var.instance}"

  storage_account_name = "st${var.project_code}${var.environment}${var.region_code}${var.instance}"

  common_tags = {
    project     = var.project_name
    environment = var.environment
    domain      = "life-insurance"
    owner       = var.owner
    managed_by  = "terraform"
  }
}
