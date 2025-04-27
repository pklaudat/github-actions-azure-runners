locals {
  github_runner_subnet = compact([
    for snet in module.private_network.subnet_ids :
    strcontains(snet.name, "github_runners") ? snet.id : null
  ])[0]
}


module "private_network" {
  source              = "./modules/network"
  location            = var.location
  address_space       = ["10.0.0.0/22"]
  route_to_firewall   = var.deploy_firewall
  firewall_private_ip = var.deploy_firewall ? module.firewall.firewall_private_ip: null
}

module "firewall" {
  count = var.deploy_firewall ? 1 : 0
  source                        = "./modules/firewall"
  firewall_location             = var.location
  firewall_name                 = "githubrunners-firewall"
  firewall_resource_group_name  = module.private_network.resource_group_name
  firewall_subnet_id            = module.private_network.firewall_subnet_id
  firewall_management_subnet_id = module.private_network.firewall_management_subnet_id
}

module "github_runners" {
  source                      = "./modules/container-apps"
  location                    = var.location
  github_organization_name    = var.github_organization_name
  github_repository_name      = var.github_repository_name
  github_runner_cpu           = var.github_runner_cpu
  github_runner_memory        = var.github_runner_memory
  github_runners_image        = var.github_runners_image
  network_resource_group_name = module.private_network.resource_group_name
  subnet_resource_id          = local.github_runner_subnet
  access_token                = var.github_pat_token
}