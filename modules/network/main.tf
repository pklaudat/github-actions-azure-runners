locals {
  snet_tiers = {
    apps = {
      size = "25"
    }
    databases = {
      size = "25"
    }
    web = {
      size = "25"
    }
    github_runners = {
      size       = "24"
      delegation = "Microsoft.App/environments"
    }
  }
}

resource "azurerm_resource_group" "network_rg" {
  name     = "githubrunners_network-rg"
  location = var.location
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = "github_runners-vnet"
  address_space       = var.address_space
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
}

resource "azurerm_network_security_group" "security_groups" {
  for_each            = local.snet_tiers
  name                = "nsg-${each.key}"
  location            = var.location
  resource_group_name = azurerm_resource_group.network_rg.name
  security_rule       = []
}

resource "azurerm_route_table" "route_table" {
  for_each            = local.snet_tiers
  name                = "udr-${each.key}"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  route = [
    {
      name                   = "default-route"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = var.route_to_firewall ? "VirtualAppliance" : "Internet"
      next_hop_in_ip_address = var.route_to_firewall ? var.firewall_private_ip : null
    }
  ]
}

resource "azurerm_subnet" "subnets" {
  for_each             = local.snet_tiers
  name                 = "snet-${each.key}"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [cidrsubnet(var.address_space[0], tonumber(each.value.size) - tonumber(split("/", var.address_space[0])[1]), index(keys(local.snet_tiers), each.key))]
  dynamic "delegation" {
    for_each = contains(keys(each.value), "delegation") ? [each.value.delegation] : []
    content {
      name = "delegation"
      service_delegation {
        name    = delegation.value
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    }
  }
  private_endpoint_network_policies = "Enabled"
  default_outbound_access_enabled   = !var.route_to_firewall
}


resource "azurerm_subnet" "firewall_subnet" {
  count                             = var.route_to_firewall ? 1 : 0
  name                              = "AzureFirewallSubnet"
  resource_group_name               = azurerm_resource_group.network_rg.name
  virtual_network_name              = azurerm_virtual_network.virtual_network.name
  address_prefixes                  = [cidrsubnet(var.address_space[0], 26 - tonumber(split("/", var.address_space[0])[1]), length(keys(local.snet_tiers)) + 1)]
  private_endpoint_network_policies = "Enabled"
  default_outbound_access_enabled   = !var.route_to_firewall
}

resource "azurerm_subnet" "firewall_management_subnet" {
  count                             = var.route_to_firewall ? 1 : 0
  name                              = "AzureFirewallManagementSubnet"
  resource_group_name               = azurerm_resource_group.network_rg.name
  virtual_network_name              = azurerm_virtual_network.virtual_network.name
  address_prefixes                  = [cidrsubnet(var.address_space[0], 26 - tonumber(split("/", var.address_space[0])[1]), length(keys(local.snet_tiers)))]
  private_endpoint_network_policies = "Enabled"
  default_outbound_access_enabled   = !var.route_to_firewall
}


resource "azurerm_subnet_network_security_group_association" "security_rules_association" {
  for_each                  = { for i, k in keys(local.snet_tiers) : i => k }
  subnet_id                 = azurerm_subnet.subnets[each.value].id
  network_security_group_id = azurerm_network_security_group.security_groups[each.value].id
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  for_each       = { for i, k in keys(local.snet_tiers) : i => k }
  subnet_id      = azurerm_subnet.subnets[each.value].id
  route_table_id = azurerm_route_table.route_table[each.value].id
}

resource "azurerm_network_watcher" "net_watcher" {
  name                = "github_runner-network_watcher"
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location
}


resource "azurerm_log_analytics_workspace" "network_logs" {
  name                = "githubrunners-networklogs"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# resource "azurerm_network_watcher_flow_log" "flow_logs" {
#     network_watcher_name = azurerm_network_watcher.net_watcher.name
#     resource_group_name = azurerm_resource_group.network_rg.name
#     name = "flowlogs-github_runners-network"
#     target_resource_id = azurerm_virtual_network.virtual_network.id
#     retention_policy {
#       enabled = true
#       days = 7
#     }
#     traffic_analytics {
#       enabled = true
#       workspace_id = azurerm_log_analytics_workspace.network_logs.workspace_id
#       workspace_region = azurerm_log_analytics_workspace.network_logs.location
#       workspace_resource_id = azurerm_log_analytics_workspace.network_logs.id
#     }

# }


