output "debug_application_rules" {
  description = "value of the application rules."
  value       = jsondecode(data.config_workbook.application_rules.json).configuration_item
}

output "debug_network_rules" {
  description = "value of the network rules."
  value       = jsondecode(data.config_workbook.network_rules.json).configuration_item
}
