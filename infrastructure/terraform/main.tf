data "azurerm_client_config" "current" {}

locals {
  resource_group_name  = "rg-${var.project_code}-${var.environment}-${var.region_code}-${var.instance}"
  key_vault_name       = "kv-${var.project_code}-${var.environment}-${var.region_code}-${var.instance}"
  storage_account_name = "st${var.project_code}${var.environment}${var.region_code}${var.instance}"
  budget_name          = "budget-${var.project_code}-${var.environment}"

  common_tags = {
    project     = var.project_name
    environment = var.environment
    domain      = "life-insurance"
    owner       = var.owner
    managed_by  = "terraform"
  }
}

resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location

  tags = local.common_tags
}

resource "azurerm_storage_account" "data" {
  name                = local.storage_account_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"

  is_hns_enabled                  = true
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  shared_access_key_enabled       = false
  default_to_oauth_authentication = true
  local_user_enabled              = false

  public_network_access = "Enabled"

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
    ip_rules       = [var.allowed_public_ip]
  }

  tags = local.common_tags
}

resource "azurerm_key_vault" "main" {
  name                = local.key_vault_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name                   = "standard"
  rbac_authorization_enabled = true

  soft_delete_retention_days = 90
  purge_protection_enabled   = true

  public_network_access_enabled = true

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = [var.allowed_public_ip]
  }

  tags = local.common_tags
}

resource "azurerm_consumption_budget_resource_group" "dev" {
  name              = local.budget_name
  resource_group_id = azurerm_resource_group.main.id

  amount     = var.monthly_budget_amount
  time_grain = "Monthly"

  time_period {
    start_date = var.budget_start_date
  }

  notification {
    enabled        = true
    threshold      = 50
    operator       = "GreaterThanOrEqualTo"
    threshold_type = "Actual"

    contact_roles = ["Owner"]
  }

  notification {
    enabled        = true
    threshold      = 80
    operator       = "GreaterThanOrEqualTo"
    threshold_type = "Actual"

    contact_roles = ["Owner"]
  }

  notification {
    enabled        = true
    threshold      = 100
    operator       = "GreaterThanOrEqualTo"
    threshold_type = "Actual"

    contact_roles = ["Owner"]
  }
}