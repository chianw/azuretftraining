resource "azurerm_virtual_network" "vnet" {
  name                = var.m_vnet_name
  location            = var.m_location
  resource_group_name = var.m_resource_group_name
  address_space       = var.m_address_space
  dns_servers         = var.m_dns_servers
  tags                = var.m_tag_name
}