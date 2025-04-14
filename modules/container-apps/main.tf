
locals {
  container_environment_variables = {
    ACCESS_TOKEN = ""
    RUNNER_SCOPE = "org"
    ORG_NAME     = var.github_organization_name
  }
}


resource "azurerm_resource_group" "runners_rg" {
  name     = "githubrunners_orch-rg"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "runners_logs" {
  name                = "githubrunners-containerlogs"
  location            = azurerm_resource_group.runners_rg.location
  resource_group_name = azurerm_resource_group.runners_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "self_hosted_runners_environment" {
  name                               = "githubrunners-env"
  location                           = azurerm_resource_group.runners_rg.location
  resource_group_name                = azurerm_resource_group.runners_rg.name
  log_analytics_workspace_id         = azurerm_log_analytics_workspace.runners_logs.id
  zone_redundancy_enabled            = true
  internal_load_balancer_enabled     = true
  infrastructure_resource_group_name = "githubrunners_instances-rg"
  infrastructure_subnet_id           = var.subnet_resource_id
  workload_profile {
    name                  = "Consumption"
    maximum_count         = 0
    minimum_count         = 0
    workload_profile_type = "Consumption"
  }
}

resource "azurerm_container_group" "self_hosted_runners" {
  name                = "github-runners"
  location            = azurerm_resource_group.runners_rg.location
  os_type             = "Linux"
  resource_group_name = azurerm_resource_group.runners_rg.name
  subnet_ids          = [var.subnet_resource_id]
  zones               = var.availabiltiy_zones

  container {
    name         = "gh-selfhosted-runners"
    image        = var.github_runners_image
    cpu          = var.github_runner_cpu
    memory       = var.github_runner_memory
    cpu_limit    = 4.0
    memory_limit = var.github_runner_memory
    secure_environment_variables = {

    }
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}

# resource "azurerm_container_app" "self_hosted_runners" {
#   name                         = "github_runners"
#   container_app_environment_id = azurerm_container_app_environment.self_hosted_runners_environment.id
#   resource_group_name          = azurerm_resource_group.runners_rg
#   revision_mode                = "Single"
#   secret {
#     name = "github-access"
#   }
#   template {
#     container {
#       name   = "gh-selfhosted-runner"
#       image  = var.github_runners_image
#       cpu    = var.github_runner_cpu
#       memory = var.github_runner_memory
#     }
#   }
# }