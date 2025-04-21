
resource "azurerm_resource_group" "runners_rg" {
  name     = "github_runners-rg"
  location = var.location
}

resource "azurerm_application_insights" "metrics" {
  name                                  = "container-env-appi"
  resource_group_name                   = azurerm_resource_group.runners_rg.name
  location                              = var.location
  local_authentication_disabled         = true
  application_type                      = "web"
  workspace_id                          = azurerm_log_analytics_workspace.runners_logs.id
  daily_data_cap_notifications_disabled = true
}


resource "azurerm_role_assignment" "metrics_publish" {
  scope                = azurerm_application_insights.metrics.id
  principal_type       = "ServicePrincipal"
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}

resource "azurerm_log_analytics_workspace" "runners_logs" {
  name                = "github-runners-containerlogs"
  location            = azurerm_resource_group.runners_rg.location
  resource_group_name = azurerm_resource_group.runners_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "self_hosted_runners_environment" {
  name                               = "runners-container-env"
  location                           = azurerm_resource_group.runners_rg.location
  resource_group_name                = azurerm_resource_group.runners_rg.name
  internal_load_balancer_enabled     = true
  infrastructure_resource_group_name = "capps_controlplane-rg"
  infrastructure_subnet_id           = var.subnet_resource_id
  zone_redundancy_enabled            = true
  workload_profile {
    name                  = "Consumption"
    maximum_count         = 0
    minimum_count         = 0
    workload_profile_type = "Consumption"
  }
  log_analytics_workspace_id = azurerm_log_analytics_workspace.runners_logs.id
}


resource "azurerm_user_assigned_identity" "identity" {
  name                = "github-runners-mi"
  resource_group_name = azurerm_resource_group.runners_rg.name
  location            = var.location
}

resource "azurerm_container_app_job" "self_hosted_runners" {
  name     = "github-runners-jobs"
  location = var.location
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.identity.id]
  }
  resource_group_name          = azurerm_resource_group.runners_rg.name
  replica_retry_limit          = var.replica_retry_limit
  container_app_environment_id = azurerm_container_app_environment.self_hosted_runners_environment.id
  replica_timeout_in_seconds   = var.replica_timeout
  dynamic "secret" {
    for_each = local.authentication_settings_github
    content {
      name  = secret.value.name
      value = secret.value.value
    }
  }
  event_trigger_config {
    parallelism              = 1
    replica_completion_count = 1
    scale {
      min_executions              = var.min_execution_count
      max_executions              = var.max_execution_count
      polling_interval_in_seconds = var.polling_interval_seconds
      rules {
        name             = "github-runner"
        custom_rule_type = "github-runner"
        metadata         = local.keda_meta_data_github
        authentication {
          trigger_parameter = "personalAccessToken"
          secret_name       = local.authentication_settings_github[0].name
        }
      }
    }
  }
  template {
    container {
      image  = var.github_runners_image
      name   = "github-runner-job"
      cpu    = var.github_runner_cpu
      memory = "${var.github_runner_memory}Gi"
      dynamic "env" {
        for_each = local.environment_variables_github
        content {
          name        = env.value.name
          value       = lookup(env.value, "value", null)
          secret_name = lookup(env.value, "secret_name", null)
        }

      }
    }
  }
}


resource "azapi_resource_action" "connect_runner" {
  resource_id = azurerm_container_app_job.self_hosted_runners.id
  type        = "Microsoft.App/jobs@2024-03-01"
  action      = "start"
  body        = {}

  lifecycle {
    replace_triggered_by = [azurerm_container_app_job.self_hosted_runners]
  }
}