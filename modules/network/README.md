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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.network_logs](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_network_security_group.security_groups](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/network_security_group) | resource |
| [azurerm_network_watcher.net_watcher](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/network_watcher) | resource |
| [azurerm_resource_group.network_rg](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/resource_group) | resource |
| [azurerm_route_table.route_table](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/route_table) | resource |
| [azurerm_subnet.firewall_management_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/subnet) | resource |
| [azurerm_subnet.firewall_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/subnet) | resource |
| [azurerm_subnet.subnets](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.security_rules_association](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.route_table_association](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space for the virtual network. | `list(string)` | <pre>[<br/>  "10.0.0.0/22"<br/>]</pre> | no |
| <a name="input_firewall_private_ip"></a> [firewall\_private\_ip](#input\_firewall\_private\_ip) | The private IP address of the firewall. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Location for the network resources. | `string` | n/a | yes |
| <a name="input_route_to_firewall"></a> [route\_to\_firewall](#input\_route\_to\_firewall) | The route to the firewall. If not provided, the default route will be used. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_management_subnet_id"></a> [firewall\_management\_subnet\_id](#output\_firewall\_management\_subnet\_id) | value of the firewall management subnet id. |
| <a name="output_firewall_subnet_id"></a> [firewall\_subnet\_id](#output\_firewall\_subnet\_id) | value of the firewall subnet id. |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | value of the resource group id. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | value of the resource group name. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | value of the subnet ids. |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | value of the virtual network id. |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | value of the virtual network name. |
<!-- END_TF_DOCS -->