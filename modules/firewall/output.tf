output "debug_application_rules" {
  description = "value of the application rules."
  value       = jsondecode(data.config_workbook.application_rules.json).configuration_item
}

output "debug_network_rules" {
  description = "value of the network rules."
  value       = jsondecode(data.config_workbook.network_rules.json).configuration_item
}

output "firewall_id" {
  description = "value of the firewall id."
  value       = azurerm_firewall.firewall.id
}

output "firewall_public_ip" {
  description = "The public IP address of the firewall."
  value       = azurerm_public_ip.firewall_public_ip.ip_address
}

output "firewall_policy_id" {
  description = "The ID of the firewall policy."
  value       = azurerm_firewall_policy.azfw_policy.id
}

output "firewall_private_ip" {
  description = "The private IP address of the firewall."
  value       = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}