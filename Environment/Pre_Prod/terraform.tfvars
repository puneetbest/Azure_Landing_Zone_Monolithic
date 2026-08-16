rsg = {
  rg1 = {
    rg_name     = "apple-rg"
    rg_location = "Central India"
  }
}

vrnet = {
  vnet1 = {
    vnet_name     = "data_vnet"
    rg_name       = "apple-rg"
    rg_location   = "centralindia"
    address_space = ["10.0.0.0/16"]
  }
}
snets = {
  snet1 = {
    snet_name      = "frontend"
    rg_name        = "apple-rg"
    rg_location    = "centralindia"
    vnet_name      = "data_vnet"
    address_prefix = ["10.0.1.0/24"]
  }
  snet2 = {
    snet_name      = "backend"
    rg_name        = "apple-rg"
    rg_location    = "centralindia"
    vnet_name      = "data_vnet"
    address_prefix = ["10.0.2.0/24"]
  }
}
puips = {
  puip1 = {
    pip_name          = "frontend_pip"
    rg_name           = "apple-rg"
    rg_location       = "centralindia"
    allocation_method = "Static"
  }
  puip2 = {
    pip_name          = "backend_pip"
    rg_name           = "apple-rg"
    rg_location       = "centralindia"
    allocation_method = "Static"
  }
}
vms = {
  vm1 = {
    vm_name              = "frontend_vm"
    nic_name             = "frontend_nic"
    rg_name              = "apple-rg"
    rg_location          = "centralindia"
    vm_size              = "Standard_DC1ds_v3"
    snet_name            = "frontend"
    vnet_name            = "data_vnet"
    puip_name            = "frontend_pip"
    ip_name              = "frontend_nic_ip"
    ip_allocation_method = "Dynamic"
    computer_name        = "frontend"
    admin_username       = "frontend"
  }
  vm2 = {
    vm_name              = "backend_vm"
    nic_name             = "backend_nic"
    rg_name              = "apple-rg"
    rg_location          = "centralindia"
    vm_size              = "Standard_DC1ds_v3"
    snet_name            = "backend"
    vnet_name            = "data_vnet"
    puip_name            = "backend_pip"
    ip_name              = "backned_nic_ip"
    ip_allocation_method = "Dynamic"
    computer_name        = "backend"
    admin_username       = "backend"
  }
}
netsg = {
  nsg1 = {
    nsg_name    = "frontend-nsg"
    rg_location = "centralindia"
    rg_name     = "apple-rg"
  }
}