<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >=3.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.26.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 5.37.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.3.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.26.0 |
| <a name="provider_github"></a> [github](#provider\_github) | 6.6.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application_federated_identity_credential.federated_creds](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_registration.github_app_registration](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_registration) | resource |
| [github_actions_secret.repository_secrets](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [time_rotating.time](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [azuread_client_config.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/data-sources/client_config) | data source |
| [github_app_token.app_token](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/app_token) | data source |
| [github_repository.repo](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id) | Github App ID. | `string` | n/a | yes |
| <a name="input_github_repository_name"></a> [github\_repository\_name](#input\_github\_repository\_name) | Github repository full name. Include repo owner. | `string` | n/a | yes |
| <a name="input_installation_id"></a> [installation\_id](#input\_installation\_id) | Installation ID for this github app. Needed to retrieve access token. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_token"></a> [token](#output\_token) | n/a |
<!-- END_TF_DOCS -->