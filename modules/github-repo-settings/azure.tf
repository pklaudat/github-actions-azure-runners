

data "azuread_client_config" "this" {}


resource "time_rotating" "time" {
  rotation_days = 180
}

resource "azuread_application_registration" "github_app_registration" {
  display_name = "Github Actions - FederatedIdentity"
  description  = "Github Actions - Federated Identity"
}

resource "azuread_application_federated_identity_credential" "federated_creds" {
  application_id = azuread_application_registration.github_app_registration.id
  display_name   = "GithubFederatedIdentity"
  description    = "Deployments for ${var.github_repository_name}"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${var.github_repository_name}:ref:refs/heads/main"
}

