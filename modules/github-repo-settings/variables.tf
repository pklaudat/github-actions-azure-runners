
variable "github_repository" {
  type = string
}

variable "app_registration_client_id" {
  type      = string
  sensitive = true
}

variable "app_registration_tenant_id" {
  type      = string
  sensitive = true
}

variable "azure_subscription_id" {
  type      = string
  sensitive = true
}