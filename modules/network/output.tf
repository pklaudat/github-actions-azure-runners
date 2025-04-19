output "subnet_ids" {
  value = [for s in azurerm_subnet.subnets : { name = "${s.name}", id = "${s.id}" }]
}

output "vnet_id" {
  value = azurerm_virtual_network.virtual_network.id
}

output "vnet_name" {
  value = azurerm_virtual_network.virtual_network.name
}

output "resource_group_name" {
  value = azurerm_resource_group.network_rg.name
}

output "resource_group_id" {
  value = azurerm_resource_group.network_rg.id
}