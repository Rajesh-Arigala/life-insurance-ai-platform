output "planned_resource_group_name" {
  description = "Planned Azure Resource Group name."
  value       = local.resource_group_name
}

output "planned_key_vault_name" {
  description = "Planned Azure Key Vault name."
  value       = local.key_vault_name
}

output "planned_storage_account_name" {
  description = "Planned Azure Storage Account name."
  value       = local.storage_account_name
}

output "azure_location" {
  description = "Planned Azure deployment region."
  value       = var.location
}

output "monthly_budget_inr" {
  description = "Planned monthly development budget."
  value       = var.monthly_budget_inr
}

output "common_tags" {
  description = "Standard tags that will be applied to Azure resources."
  value       = local.common_tags
}