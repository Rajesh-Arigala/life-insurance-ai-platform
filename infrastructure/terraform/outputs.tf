output "resource_group_name" {
  description = "Azure DEV Resource Group name."
  value       = azurerm_resource_group.main.name
}

output "storage_account_name" {
  description = "Azure ADLS Gen2 Storage Account name."
  value       = azurerm_storage_account.data.name
}

output "key_vault_name" {
  description = "Azure Key Vault name."
  value       = azurerm_key_vault.main.name
}

output "azure_location" {
  description = "Azure deployment region."
  value       = var.location
}

output "monthly_budget_amount" {
  description = "Monthly DEV budget in the subscription billing currency."
  value       = var.monthly_budget_amount
}
