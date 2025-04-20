
variable "location" {
  type = string
  description = "Location where to host the self hosted runners in azure."
}

variable "github_runners_image" {
  type    = string
  default = "pklaudat/github-actions"
  description = "Runner container image used in azure container apps jobs."
}

variable "github_runner_cpu" {
  type    = number
  default = 0.25
  description = "CPU size for the self hosted runners."
}

variable "github_runner_memory" {
  type    = number
  default = 0.5
  description = "Memory size in Gib for the self hosted runners."
}

variable "github_organization_name" {
  type    = string
  default = "pklaudat"
  description = "Github org name. Use REPO Owner id in case no organization is created."
}

variable "github_repository_name" {
  type = string
  description = "Github repository name that the self hosted runners can register themselves."
}

variable "github_pat_token" {
  type      = string
  sensitive = true
  description = "Github Personal Access Token (Sensitive). Please don't hardcode this in the repository."
}