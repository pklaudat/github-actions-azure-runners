variable "firewall_subnet_id" {
  description = "The ID of the subnet for the firewall."
  type        = string
}

variable "firewall_management_subnet_id" {
  description = "The ID of the management subnet for the firewall."
  type        = string

}

variable "firewall_name" {
  description = "The name of the firewall."
  type        = string

}

variable "firewall_policy_sku" {
  description = "The SKU of the firewall policy."
  type        = string
  default     = "Basic"
}

variable "firewall_sku_tier" {
  description = "value of the SKU for the firewall."
  type        = string
  default     = "Basic"
}

variable "firewall_resource_group_name" {
  description = "The name of the resource group for the firewall."
  type        = string
}

variable "firewall_location" {
  description = "The location for the firewall resource group."
  type        = string
}