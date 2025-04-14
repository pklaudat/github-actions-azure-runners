locals {
  github_runner_subnet = compact([
    for snet in module.private_network.subnet_ids :
    strcontains(snet.name, "github_runners") ? snet.id : null
  ])[0]
}


variable "location" {
    type = string
  
}

module "private_network" {
    source = "./modules/network"
    location = var.location
    address_space = ["10.0.0.0/22"] 
}

output "test" {
    value = local.github_runner_subnet
}

module "github_runners" {
    source = "./modules/container-apps"
    location = var.location
    github_organization_name = "org"
    github_runner_cpu = 0.5
    github_runner_memory = 0.5
    github_runners_image = "docker/github-actions"
    availabiltiy_zones = ["1"]
    network_resource_group_name = module.private_network.resource_group_name
    subnet_resource_id = local.github_runner_subnet
}