
module "resurce_group" {
  source = "../../Modules/resource_group"
  rg     = var.rsg
}

module "vnet" {
  source     = "../../Modules/virtual_network"
  depends_on = [module.resurce_group]
  vnet       = var.vrnet
}

module "vnet_peering" {
  source     = "../../Modules/vnet_peering"
  depends_on = [module.vnet]
  vnetpeer   = var.vnetpeers
}

module "subnets" {
  source     = "../../Modules/subnet"
  depends_on = [module.vnet]
  snet       = var.snets
}

module "public_ips" {
  source     = "../../Modules/public_ip"
  depends_on = [module.resurce_group]
  puip       = var.puips

}

module "bastion" {
  source     = "../../Modules/bastion"
  depends_on = [module.subnets]
  bastion    = var.landing_bastion
}

module "virtual_machines" {
  depends_on = [module.subnets, module.public_ips, module.keyvault]
  source     = "../../Modules/virtual_machine"
  vm         = var.vms
}
module "network_seurity_group" {
  source     = "../../Modules/nsg"
  depends_on = [module.subnets]
  nsg        = var.netsg
}
module "keyvault" {
  source     = "../../Modules/keyvault"
  depends_on = [module.resurce_group]
  keyvault   = var.keyvaults
}