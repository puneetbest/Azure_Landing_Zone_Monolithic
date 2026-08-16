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
#checkov:skip=CKV2_AZURE_10:Microsoft Antimalware extension is not supported for this Linux VM. Linux endpoint protection is managed through the organization's approved Linux security solut
resource "azurerm_virtual_machine" "virtual_machine" {
  for_each              = var.vm
  name                  = each.value.vm_name
  resource_group_name   = each.value.rg_name
  location              = each.value.rg_location
  network_interface_ids = [resource.azurerm_network_interface.NIC[each.key].id]
  vm_size               = each.value.vm_size

  storage_os_disk {
    name              = "${each.key}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  os_profile {
    computer_name  = each.value.computer_name
    admin_username = each.value.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${each.value.admin_username}/.ssh/authorized_keys"
      key_data = var.ssh_public_key
    }
  }
}