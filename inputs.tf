###############################
# Global variables
###############################

variable "client_name" {
  description = "Client name"
  type        = "string"
}

variable "environment" {
  description = "Environment name"
  type        = "string"
}

variable "stack" {
  description = "Stack name"
  type        = "string"
}

variable "resource_group_name" {
  description = "Resource Group the resources will belong to"
  type        = "string"
}

variable "location" {
  description = "Azure location."
  type        = "string"
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = "string"
}

variable "name_prefix" {
  description = "Name prefix for all resources generated name"
  type        = "string"
  default     = ""
}

variable "extra_tags" {
  description = "Extra tags to add"
  type        = "map"
  default     = {}
}

###############################
# Azure Recovery Vault variables
###############################
variable "recovery_vault_custom_name" {
  description = "Azure Recovery Vault custom name. Empty by default, using naming convention."
  type        = "string"
  default     = ""
}

variable "recovery_vault_sku" {
  description = "Azure Recovery Vault SKU. Possible values include: `Standard`, `RS0`. Default to `Standard`."
  type        = "string"
  default     = "Standard"
}

variable "vm_backup_policy_custom_name" {
  description = "Azure Backup - VM backup policy custom name. Empty by default, using naming convention."
  type        = "string"
  default     = ""
}

variable "vm_backup_policy_timezone" {
  description = "Specifies the timezone for schedules. Defaults to `UTC`."
  type        = "string"
  default     = "UTC"
}

variable "vm_backup_policy_time" {
  description = "The time of day to preform the backup in 24hour format."
  type        = "string"
  default     = "04:00"
}

variable "vm_backup_policy_retention" {
  description = "The number of daily backups to keep. Must be between 1 and 9999."
  type        = "string"
  default     = "30"
}
