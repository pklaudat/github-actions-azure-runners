


locals {
  actions_secret = {
    AZURE_CLIENT_ID       = azuread_application_registration.github_app_registration.client_id
    AZURE_TENANT_ID       = data.azurerm_client_config.this.tenant_id
    AZURE_SUBSCRIPTION_ID = data.azurerm_client_config.this.subscription_id
  }
}

data "azurerm_client_config" "this" {}

data "github_app_token" "app_token" {
  app_id          = var.github_app_id
  installation_id = var.installation_id
  pem_file        = file("privatekey.pem")
}

data "github_repository" "repo" {
  full_name = var.github_repository_name

}

resource "github_actions_secret" "repository_secrets" {
  for_each        = local.actions_secret
  repository      = data.github_repository.repo.full_name
  secret_name     = each.key
  plaintext_value = each.value
}

output "token" {
  value     = data.github_app_token.app_token.token
  sensitive = true
}