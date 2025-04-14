
variable "location" {
  type    = string
  default = "eastus"
}

variable "github_runner_cpu" {
  type    = number
  default = 0.5
}

variable "github_runner_memory" {
  type    = number
  default = 0.5
}

variable "github_runners_image" {
  type = string
}

variable "github_organization_name" {
  type = string
}


variable "network_resource_group_name" {
  type = string
}

variable "subnet_resource_id" {
  type = string
}

variable "availabiltiy_zones" {
    type = list(string)

}