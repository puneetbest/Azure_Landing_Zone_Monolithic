data "azurerm_virtual_network" "virtnet" {
  for_each = var.vnetpeer  
  name                = each.value.remote_vnet_name
  resource_group_name = each.value.rg_name
}