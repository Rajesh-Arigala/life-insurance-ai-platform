locals {
  resource_group_name  = "rg-${var.project_code}-tfstate-${var.region_code}-${var.instance}"
  storage_account_name = "st${var.project_code}tfstate${var.region_code}${var.instance}"

  common_tags = {
    project    = "life-insurance-ai"
    purpose    = "terraform-state"
    owner      = var.owner
    managed_by = "terraform"
  }
}

resource "azurerm_resource_group" "tfstate" {
  name     = local.resource_group_name
  location = var.location

  tags = local.common_tags
}

resource "azurerm_storage_account" "tfstate" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access           = "Enabled"

  tags = local.common_tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.state_container_name
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}
