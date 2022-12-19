module "virtual_network_peerings" {
  source               = "./modules/virtual_network_peering"
  for_each             = var.virtual_network_peerings
  peerings             = each.value.peerings
  virtual_network_name = module.virtual_network[each.key].name
  virtual_networks     = module.virtual_network
}