resource "azurerm_bastion_host" "bastion" {
  for_each = var.bastion  
  name                = each.value.bastion_name
  location            = each.value.rg_location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                 = each.value.ipconf_name
    subnet_id            = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pub_ip[each.key].id
  }
}