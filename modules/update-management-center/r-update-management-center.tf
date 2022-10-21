# https://learn.microsoft.com/en-us/azure/update-center/manage-vms-programmatically?tabs=cli%2Crest
#locals {
#  maintenanceConfigurations = {
#
#    windowsSecondTuesday = {
#      location = module.rg.resource_group_location
#      properties = {
#        namespace = null
#        extensionProperties = {
#          InGuestPatchMode = "User" # Mandatory at first execution but generate perpetual diff after...
#        }
#        maintenanceScope = "InGuestPatch"
#        maintenanceWindow = {
#          startDateTime = "2021-08-21 04:00"
#          duration      = "02:00"
#          timeZone      = "UTC"
#          recurEvery    = "1Month Second Tuesday"
#        }
#        visibility = "Custom"
#        installPatches = {
#          rebootSetting = "IfRequired"
#          windowsParameters = {
#            classificationsToInclude = [
#              "Critical",
#              "Definition",
#              "FeaturePack",
#              "Security",
#              "ServicePack",
#              "Tools",
#              "UpdateRollup",
#              "Updates"
#            ]
#          }
#          linuxParameters = {
#            classificationsToInclude = [
#              "Critical",
#              "Security",
#              "Other",
#            ]
#          }
#        }
#      }
#    }
#    windowsFirstTuesday = {
#      location = module.rg.resource_group_location
#      properties = {
#        namespace = null
#        extensionProperties = {
#          InGuestPatchMode = "User"
#        }
#        maintenanceScope = "InGuestPatch"
#        maintenanceWindow = {
#          startDateTime = "2021-08-21 04:00"
#          duration      = "02:00"
#          timeZone      = "UTC"
#          recurEvery    = "1Month First Tuesday"
#        }
#        visibility = "Custom"
#        installPatches = {
#          rebootSetting = "IfRequired"
#          windowsParameters = {
#            classificationsToInclude = [
#              "Critical",
#              "Definition",
#              "FeaturePack",
#              "Security",
#              "ServicePack",
#              "Tools",
#              "UpdateRollup",
#              "Updates"
#            ]
#          }
#          linuxParameters = {
#            classificationsToInclude = [
#              "Critical",
#              "Security",
#              "Other",
#            ]
#          }
#        }
#      }
#    }
#    windowsThirdTuesday = {
#      location = module.rg.resource_group_location
#      properties = {
#        namespace = null
#        extensionProperties = {
#          InGuestPatchMode = "User"
#        }
#        maintenanceScope = "InGuestPatch"
#        maintenanceWindow = {
#          startDateTime = "2021-08-21 04:00"
#          duration      = "02:00"
#          timeZone      = "UTC"
#          recurEvery    = "1Month Third Tuesday"
#        }
#        visibility = "Custom"
#        installPatches = {
#          rebootSetting = "IfRequired"
#          windowsParameters = {
#            classificationsToInclude = [
#              "Critical",
#              "Definition",
#              "FeaturePack",
#              "Security",
#              "ServicePack",
#              "Tools",
#              "UpdateRollup",
#              "Updates"
#            ]
#          }
#          linuxParameters = {
#            classificationsToInclude = [
#              "Critical",
#              "Security",
#              "Other",
#            ]
#          }
#        }
#      }
#    }
#    windowsLastTuesday = {
#      location = module.rg.resource_group_location
#      properties = {
#        namespace = null
#        extensionProperties = {
#          InGuestPatchMode = "User"
#        }
#        maintenanceScope = "InGuestPatch"
#        maintenanceWindow = {
#          startDateTime = "2021-08-21 04:00"
#          duration      = "02:00"
#          timeZone      = "UTC"
#          recurEvery    = "1Month Last Tuesday"
#        }
#        visibility = "Custom"
#        installPatches = {
#          rebootSetting = "IfRequired"
#          windowsParameters = {
#            classificationsToInclude = [
#              "Critical",
#              "Definition",
#              "FeaturePack",
#              "Security",
#              "ServicePack",
#              "Tools",
#              "UpdateRollup",
#              "Updates"
#            ]
#          }
#          linuxParameters = {
#            classificationsToInclude = [
#              "Critical",
#              "Security",
#              "Other",
#            ]
#          }
#        }
#      }
#    }
#  }
#}

resource "azapi_resource" "maintenance_configurations" {
  for_each  = { for config in var.maintenance_configurations : config.configuration_name => config }
  name      = "mc-${each.key}"
  parent_id = var.resource_group_name
  type      = "Microsoft.Maintenance/maintenanceConfigurations@2021-09-01-preview"
  body = jsonencode(
    {
      location = var.location
      properties = {
        namespace = null
        extensionProperties = {
          InGuestPatchMode = "User"
        }
        maintenanceScope = "InGuestPatch"
        maintenanceWindow = {
          startDateTime = each.value.start_date_time
          duration      = each.value.duration
          timeZone      = each.value.time_zone
          recurEvery    = each.value.recur_every
        }
        visibitlity = "Custom"
        installPatches = {
          rebootSetting = each.value.reboot_setting
          windowsParameters = {
            classificationsToInclude = each.value.windows_classifications_to_include
          }
          linuxParameters = {
            classificationsToInclude = each.value.linux_classifications_to_include
          }
        }
      }
    }
  )
  tags                    = local.tags
  response_export_values  = ["*"]
  ignore_missing_property = true
}




# VM Patch mode must be AutomaticByPlatform
resource "azapi_resource" "virtual_machines_associations" {
  for_each  = toset(var.virtual_machines_associations)
  name      = "${split("/", each.value.virtual_machine_id)[7]}-schedule"
  location  = var.location
  parent_id = each.value.virtual_machine_id
  type      = "Microsoft.Maintenance/configurationAssignments@2021-09-01-preview"
  body = jsonencode({
    properties = {
      maintenanceConfigurationId = jsondecode(azapi_resource.maintenance_configurations[each.value.maintenance_configuration_name].output)["id"]
    }
  })
  tags                    = local.tags
  response_export_values  = ["*"]
  ignore_missing_property = true
}

