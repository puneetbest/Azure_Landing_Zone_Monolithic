resource "azurerm_public_ip" "pub_ip" {
  for_each            = var.puip
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
  location            = each.value.rg_location
  allocation_method   = each.value.allocation_method
}
