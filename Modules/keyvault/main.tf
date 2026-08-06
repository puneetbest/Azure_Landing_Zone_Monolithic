
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  for_each = var.keyvault
  name                        = each.value.keyvault_name
  location                    = each.value.rg_location
  resource_group_name         = each.value.rg_name
  rbac_authorization_enabled  = false
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}