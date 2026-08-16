
module "resurce_group" {
  source = "../../Modules/resource_group"
  rg     = var.rsg
}

module "vnet" {
  source     = "../../Modules/virtual_network"
  depends_on = [module.resurce_group]
  vnet       = var.vrnet
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

module "virtual_machines" {
  depends_on = [module.subnets, module.public_ips]
  source     = "../../Modules/virtual_machine"
  vm         = var.vms

}

module "network_seurity_group" {
  source     = "../../Modules/nsg"
  depends_on = [module.subnets]
  nsg        = var.netsg
}