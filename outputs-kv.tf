###############################
# Key Vault outputs
###############################
output "keyvault_resource_group_name" {
  description = "Resource Group of the Key Vault."
  value       = var.keyvault_resource_group_name
}

output "keyvault_id" {
  description = "ID of the Key Vault."
  value       = module.keyvault.key_vault_id
}

output "keyvault_name" {
  description = "Name of the Key Vault."
  value       = module.keyvault.key_vault_name
}

output "keyvault_uri" {
  description = "URI of the Key Vault."
  value       = module.keyvault.key_vault_uri
}
