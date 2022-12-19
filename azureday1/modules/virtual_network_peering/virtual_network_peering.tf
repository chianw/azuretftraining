
module "peering" {
  source                    = "./peering"
  for_each                  = var.peerings
  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = var.virtual_network_name
  remote_virtual_network_id = var.virtual_networks[each.key].id
}