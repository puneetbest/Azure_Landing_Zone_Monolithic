resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsg  
  name                = each.value.nsg_name
  location            = each.value.rg_location
  resource_group_name = each.value.rg_name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}