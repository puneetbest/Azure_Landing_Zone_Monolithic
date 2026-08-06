data "azurerm_subnet" "subnet" {
  for_each             = var.vm
  name                 = each.value.snet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}
data "azurerm_public_ip" "pub_ip" {
  for_each            = var.vm
  name                = each.value.puip_name
  resource_group_name = each.value.rg_name
}
data "azurerm_key_vault" "keyvault" {
  for_each = var.vm
  name = each.value.keyvault_name
  resource_group_name = each.value.rg_name
}

resource "azurerm_key_vault_secret" "vm_password" {
  for_each = var.vm
  name         = each.value.kv_secret_password
  value        = random_password.vm_password[each.key].result
  key_vault_id = data.azurerm_key_vault.keyvault[each.key].id
}

resource "random_password" "vm_password" {
  for_each = var.vm
  length           = 16
  special          = true
  override_special = "!@#$%^&*()-_=+"
}

resource "azurerm_network_interface" "NIC" {
  for_each            = var.vm
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
  location            = each.value.rg_location

  ip_configuration {
    name                          = each.value.ip_name
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id          = data.azurerm_public_ip.pub_ip[each.key].id
    private_ip_address_allocation = each.value.ip_allocation_method
  }
}
resource "azurerm_linux_virtual_machine" "virtual_machine" {
  for_each = var.vm
  name                = each.value.vm_name
  computer_name       = each.value.computer_name
  resource_group_name = each.value.rg_name
  location            = each.value.rg_location
  size = each.value.vm_size
  network_interface_ids = [azurerm_network_interface.NIC[each.key].id]
  admin_username = each.value.vm_username
  admin_password = azurerm_key_vault_secret.vm_password[each.key].value
  disable_password_authentication = false

  os_disk {
    name                 = "${each.key}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  custom_data = base64encode(
    file("${path.module}/install.sh")
  )
}