


locals {
  actions_secret = {
    AZURE_CLIENT_ID       = var.app_registration_client_id
    AZURE_TENANT_ID       = var.app_registration_tenant_id
    AZURE_SUBSCRIPTION_ID = var.azure_subscription_id
  }
}

resource "github_actions_secret" "repository_secrets" {
  for_each        = local.actions_secret
  repository      = var.github_repository
  secret_name     = each.key
  plaintext_value = each.value
}