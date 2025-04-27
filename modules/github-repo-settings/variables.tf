
variable "github_repository_name" {
  type        = string
  description = "Github repository full name. Include repo owner."
}

variable "github_app_id" {
  type        = string
  description = "Github App ID."
  sensitive   = true
}

variable "installation_id" {
  type        = string
  description = "Installation ID for this github app. Needed to retrieve access token."
}