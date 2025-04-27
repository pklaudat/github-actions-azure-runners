output "subnet_ids" {
  description = "value of the subnet ids."
  value       = [for s in azurerm_subnet.subnets : { name = "${s.name}", id = "${s.id}" }]
}

output "vnet_id" {
  description = "value of the virtual network id."
  value       = azurerm_virtual_network.virtual_network.id
}

output "vnet_name" {
  description = "value of the virtual network name."
  value       = azurerm_virtual_network.virtual_network.name
}

output "resource_group_name" {
  description = "value of the resource group name."
  value       = azurerm_resource_group.network_rg.name
}

output "resource_group_id" {
  description = "value of the resource group id."
  value       = azurerm_resource_group.network_rg.id
}

output "firewall_subnet_id" {
  description = "value of the firewall subnet id."
  value       = var.route_to_firewall ? azurerm_subnet.firewall_subnet[0].id : null
}

output "firewall_management_subnet_id" {
  description = "value of the firewall management subnet id."
  value       = var.route_to_firewall ? azurerm_subnet.firewall_management_subnet[0].id : null
}