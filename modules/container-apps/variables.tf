
variable "location" {
  type    = string
  default = "eastus"
}


variable "github_repository_name" {
  type        = string
  description = "Github repository name."
}


variable "github_runner_cpu" {
  type        = number
  description = "Github runner cpu size."
  default     = 0.25
}

variable "github_runner_memory" {
  type        = number
  description = "Runner memory size in Gib."
  default     = 0.5
}

variable "github_runners_image" {
  type        = string
  description = "Container image being used to execute the runners."
  default     = "pklaudat/github-actions"
}

variable "github_organization_name" {
  type        = string
  description = "Github org name - known as owner name. In case there is no organization use the user id."
}


variable "network_resource_group_name" {
  type        = string
  description = "Resource group where the private network is hosted."
}

variable "subnet_resource_id" {
  type        = string
  description = "Subnet Resource id - used in the container environment. Bind service to a private network for secure deployments."
}

variable "max_execution_count" {
  type        = number
  description = "The maximum number of executions to spawn per polling interval."
  default     = 4
}

variable "min_execution_count" {
  type        = number
  description = "The minimum number of executions to spawn per polling interval."
  default     = 0
}

variable "polling_interval_seconds" {
  type        = number
  description = "How often should the pipeline queue be checked for new events, in seconds."
  default     = 30
}

variable "replica_retry_limit" {
  type        = number
  description = "The number of times to retry the runner Container Apps job."
  default     = 0
}

variable "replica_timeout" {
  type        = number
  description = "The timeout in seconds for the runner Container Apps job."
  default     = 1800
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}

variable "access_token" {
  type      = string
  sensitive = true
}