data "config_workbook" "application_rules" {
  csv = file("${path.module}/firewall_rules/application_firewall_rules.csv")
}

data "config_workbook" "network_rules" {
  csv = file("${path.module}/firewall_rules/network_firewall_rules.csv")
}



data "azurerm_resource_group" "firewall_rg" {
  name = var.firewall_resource_group_name
}

resource "azurerm_firewall_policy" "azfw_policy" {
  name                     = "azfw-policy"
  resource_group_name      = data.azurerm_resource_group.firewall_rg.name
  location                 = data.azurerm_resource_group.firewall_rg.location
  sku                      = var.firewall_policy_sku
  threat_intelligence_mode = "Alert"
}

resource "azurerm_public_ip" "firewall_public_ip" {
  name                = "pip-${var.firewall_name}-${var.firewall_location}"
  location            = data.azurerm_resource_group.firewall_rg.location
  resource_group_name = data.azurerm_resource_group.firewall_rg.name
  sku                 = "Standard"
  allocation_method   = "Static"
}

resource "azurerm_public_ip" "firewall_management_public_ip" {
  name                = "pip-${var.firewall_name}-management-${var.firewall_location}"
  location            = data.azurerm_resource_group.firewall_rg.location
  resource_group_name = data.azurerm_resource_group.firewall_rg.name
  sku                 = "Standard"
  allocation_method   = "Static"
}

resource "azurerm_firewall" "firewall" {
  name                = "fw-${var.firewall_name}-${var.firewall_location}"
  location            = data.azurerm_resource_group.firewall_rg.location
  resource_group_name = data.azurerm_resource_group.firewall_rg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = var.firewall_sku_tier
  management_ip_configuration {
    name                 = "AzureFirewallManagementSubnet"
    subnet_id            = var.firewall_management_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_management_public_ip.id
  }
  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "net_policy_rule_collection_group" {
  name               = "DefaultNetworkRuleCollectionGroup"
  firewall_policy_id = azurerm_firewall_policy.azfw_policy.id
  priority           = 200

  network_rule_collection {
    name     = "DefaultNetworkRuleCollection"
    action   = "Allow"
    priority = 200

    dynamic "rule" {
      for_each = jsondecode(data.config_workbook.network_rules.json).configuration_item
      content {
        name                  = rule.value["Name"]
        source_addresses      = [rule.value["Source"]]
        destination_ports     = split(",", rule.value["Port"])
        destination_addresses = split(",", rule.value["Destination"])
        protocols             = split(",", rule.value["Protocol"])
      }
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "app_policy_rule_collection_group" {
  name               = "DefaultApplicationRuleCollectionGroup"
  firewall_policy_id = azurerm_firewall_policy.azfw_policy.id
  priority           = 300

  application_rule_collection {
    name     = "DefaultApplicationRuleCollection"
    action   = "Allow"
    priority = 500

    dynamic "rule" {
      for_each = jsondecode(data.config_workbook.application_rules.json).configuration_item
      content {
        name              = rule.value["Name"]
        source_addresses  = [rule.value["Source"]]
        destination_fqdns = split(",", rule.value["Destination"])

        protocols {
          type = rule.value["Protocol"]
          port = length(trimspace(rule.value["Port"])) > 0 ? tonumber(rule.value["Port"]) : null
        }

        terminate_tls = false
      }
    }
  }
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
