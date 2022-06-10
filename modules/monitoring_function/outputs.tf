output "service_plan_id" {
  description = "ID of the created Service Plan"
  value       = module.function.service_plan_id
}

output "service_plan_name" {
  description = "Name of the created Service Plan"
  value       = module.function.service_plan_name
}

output "storage_account_id" {
  description = "Id of the associated Storage Account, empty if connection string provided"
  value       = module.function.storage_account_id
}

output "storage_account_name" {
  description = "Name of the associated Storage Account, empty if connection string provided"
  value       = module.function.storage_account_name
}

output "storage_account_primary_connection_string" {
  description = "Primary connection string of the associated Storage Account, empty if connection string provided"
  value       = module.function.storage_account_primary_connection_string
  sensitive   = true
}

output "storage_account_primary_access_key" {
  description = "Primary connection string of the associated Storage Account, empty if connection string provided"
  value       = module.function.storage_account_primary_access_key
  sensitive   = true
}

output "storage_account_secondary_connection_string" {
  description = "Secondary connection string of the associated Storage Account, empty if connection string provided"
  value       = module.function.storage_account_secondary_connection_string
  sensitive   = true
}

output "storage_account_secondary_access_key" {
  description = "Secondary connection string of the associated Storage Account, empty if connection string provided"
  value       = module.function.storage_account_secondary_access_key
  sensitive   = true
}

output "application_insights_id" {
  description = "Id of the associated Application Insights"
  value       = module.function.application_insights_id
}

output "application_insights_name" {
  description = "Name of the associated Application Insights"
  value       = module.function.application_insights_name
}

output "application_insights_app_id" {
  description = "App id of the associated Application Insights"
  value       = module.function.application_insights_app_id
}

output "application_insights_instrumentation_key" {
  description = "Instrumentation key of the associated Application Insights"
  value       = module.function.application_insights_instrumentation_key
  sensitive   = true
}

output "application_insights_application_type" {
  description = "Application Type of the associated Application Insights"
  value       = module.function.application_insights_application_type
}

output "function_app_id" {
  description = "Id of the created Function App"
  value       = module.function.function_app_id
}

output "function_app_name" {
  description = "Name of the created Function App"
  value       = module.function.function_app_name
}

output "function_app_outbound_ip_addresses" {
  description = "Outbound IP adresses of the created Function App"
  value       = module.function.function_app_outbound_ip_addresses
}

output "function_app_connection_string" {
  description = "Connection string of the created Function App"
  value       = module.function.function_app_connection_string
  sensitive   = true
}

output "function_app_identity" {
  value       = module.function.function_app_identity
  description = "Identity block output of the Function App"
}

output "storage_queries_table_name" {
  value       = azurerm_storage_table.queries.name
  description = "Name of the table in the Storage Account "
}
