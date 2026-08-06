resource "azurerm_virtual_network_peering" "peering" {
  for_each = var.vnetpeer
  name                      = each.value.peering_name
  resource_group_name       = each.value.rg_name
  virtual_network_name      = each.value.vnet_name
  remote_virtual_network_id = data.azurerm_virtual_network.virtnet[each.key].id
}