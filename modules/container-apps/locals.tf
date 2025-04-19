locals {
  keda_meta_data       = tomap(jsondecode(local.keda_meta_data_final))
  keda_meta_data_final = jsonencode(local.keda_meta_data_github)
  keda_meta_data_github = {
    owner                     = var.github_organization_name
    repos                     = var.github_repository_name
    targetWorkflowQueueLength = 1
    runnerScope               = "repository"
  }
  environment_variables_github = [
    # {
    #   name  = "REPO_OWNER"
    #   value = var.github_organization_name
    # },
    # {
    #   name  = "REPO_NAME"
    #   value = var.github_repository_name
    # },
    {
      name        = "GITHUB_PAT"
      secret_name = local.authentication_settings_github[0].name
    },
    {
      name  = "GH_URL"
      value = "https://github.com/${var.github_organization_name}/${var.github_repository_name}"
    },
    {
      name  = "REGISTRATION_TOKEN_API_URL"
      value = "https://api.github.com/repos/${var.github_organization_name}/${var.github_repository_name}/actions/runners/registration-token"
    }
  ]
  authentication_settings_github = [
    {
      name  = "access-token"
      value = var.access_token
    }
  ]
}