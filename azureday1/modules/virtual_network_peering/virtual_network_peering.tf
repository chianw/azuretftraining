resource "azurerm_virtual_network_peering" "peer" {
  for_each                     = var.peerings
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  virtual_network_name         = var.virtual_network_name
  remote_virtual_network_id    = var.virtual_networks[each.key].id
  allow_virtual_network_access = try(each.value.allow_virtual_network_access, null)
  allow_gateway_transit        = try(each.value.allow_gateway_transit, null)
  allow_forwarded_traffic      = try(each.value.allow_forwarded_traffic, null)
}