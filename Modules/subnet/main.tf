resource "azurerm_subnet" "subnet" {
  for_each             = var.snet
  name                 = each.value.snet_name
  resource_group_name  = each.value.rg_name
  address_prefixes =        each.value.address_prefix
  virtual_network_name = each.value.vnet_name
}