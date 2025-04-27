<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.26.0 |
| <a name="provider_config"></a> [config](#provider\_config) | 0.2.8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/firewall) | resource |
| [azurerm_firewall_policy.azfw_policy](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/firewall_policy) | resource |
| [azurerm_firewall_policy_rule_collection_group.app_policy_rule_collection_group](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/firewall_policy_rule_collection_group) | resource |
| [azurerm_firewall_policy_rule_collection_group.net_policy_rule_collection_group](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/firewall_policy_rule_collection_group) | resource |
| [azurerm_public_ip.firewall_management_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/public_ip) | resource |
| [azurerm_public_ip.firewall_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.firewall_rg](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/data-sources/resource_group) | data source |
| [config_workbook.application_rules](https://registry.terraform.io/providers/alabuel/config/latest/docs/data-sources/workbook) | data source |
| [config_workbook.network_rules](https://registry.terraform.io/providers/alabuel/config/latest/docs/data-sources/workbook) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall_location"></a> [firewall\_location](#input\_firewall\_location) | The location for the firewall resource group. | `string` | n/a | yes |
| <a name="input_firewall_management_subnet_id"></a> [firewall\_management\_subnet\_id](#input\_firewall\_management\_subnet\_id) | The ID of the management subnet for the firewall. | `string` | n/a | yes |
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name) | The name of the firewall. | `string` | n/a | yes |
| <a name="input_firewall_policy_sku"></a> [firewall\_policy\_sku](#input\_firewall\_policy\_sku) | The SKU of the firewall policy. | `string` | `"Basic"` | no |
| <a name="input_firewall_resource_group_name"></a> [firewall\_resource\_group\_name](#input\_firewall\_resource\_group\_name) | The name of the resource group for the firewall. | `string` | n/a | yes |
| <a name="input_firewall_sku_tier"></a> [firewall\_sku\_tier](#input\_firewall\_sku\_tier) | value of the SKU for the firewall. | `string` | `"Basic"` | no |
| <a name="input_firewall_subnet_id"></a> [firewall\_subnet\_id](#input\_firewall\_subnet\_id) | The ID of the subnet for the firewall. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_debug_application_rules"></a> [debug\_application\_rules](#output\_debug\_application\_rules) | value of the application rules. |
| <a name="output_debug_network_rules"></a> [debug\_network\_rules](#output\_debug\_network\_rules) | value of the network rules. |
| <a name="output_firewall_id"></a> [firewall\_id](#output\_firewall\_id) | value of the firewall id. |
| <a name="output_firewall_policy_id"></a> [firewall\_policy\_id](#output\_firewall\_policy\_id) | The ID of the firewall policy. |
| <a name="output_firewall_private_ip"></a> [firewall\_private\_ip](#output\_firewall\_private\_ip) | The private IP address of the firewall. |
| <a name="output_firewall_public_ip"></a> [firewall\_public\_ip](#output\_firewall\_public\_ip) | The public IP address of the firewall. |
<!-- END_TF_DOCS -->