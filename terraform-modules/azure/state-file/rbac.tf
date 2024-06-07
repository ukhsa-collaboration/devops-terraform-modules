# # Create a custom role with RBAC
# resource "azurerm_role_definition" "this" {
# for_each  = var.role_definition
#   name        = "${each.key}-${var.environment}$-stateblob-write-access"
#   scope       = data.azurerm_subscription.this.id
#   description = "Custom role definition allowing write access to the storage account ${azurerm_storage_account.this[each.value.storage_account_name].name}."
 
#  dynamic "permissions" {
#   for_each = each.value.permissions[*]
#   content {
#     actions = var.actions
#     data_actions = var.data_actions
#   }
#   }
#   assignable_scopes = [data.azurerm_subscription.this.id]
# }


# ### TO DO build module, check console, build dev shared services blob and application blob, test storing some state file in both.