# Self-Hosted GitHub Runners on Azure Container Apps

This repository contains Terraform code to deploy self-hosted GitHub runners using **Azure Container Apps**. The container apps are integrated into a **Virtual Network (VNet)**, where **egress traffic is routed through Azure Firewall** for secure outbound communication.
![runners](documents/actions-runners.png)

## 🚀 Features

- **Self-hosted GitHub Runners** deployed as Container Apps
- Secure **Virtual Network integration**
- **Azure Firewall** as the egress point for all outbound traffic
- Configurable runner image, GitHub token, and repo/organization binding
- Modular and reusable Terraform setup

## 📦 Components

- **Azure Container Apps**: Hosts the runner containers
- **Azure VNet and Subnets**: Provides network isolation
- **Azure Firewall**: Secures outbound traffic
- **Log Analytics**: Collects container logs
- **User Assigned Managed Identity**: For fine-grained access control - runners to azure

## 🔧 Prerequisites

- Terraform >= 1.7.0
- Azure CLI authenticated
- GitHub PAT (Personal Access Token) with `repo` permissions
- GitHub repository or organization access to register the runner


## ⚙️ Usage

1. **Clone the repository**

```bash
git clone https://github.com/pklaudat/github-actions-azure-runners.git
cd github-actions-azure-runners
```

<!-- BEGIN_TF_DOCS -->

## Terraform Module Documentation

###  Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ./modules/firewall | n/a |
| <a name="module_github_runners"></a> [github\_runners](#module\_github\_runners) | ./modules/container-apps | n/a |
| <a name="module_private_network"></a> [private\_network](#module\_private\_network) | ./modules/network | n/a |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_firewall"></a> [deploy\_firewall](#input\_deploy\_firewall) | Deploy a firewall to restrict access to the self hosted runners. | `bool` | `false` | no |
| <a name="input_github_organization_name"></a> [github\_organization\_name](#input\_github\_organization\_name) | Github org name. Use REPO Owner id in case no organization is created. | `string` | `"pklaudat"` | no |
| <a name="input_github_pat_token"></a> [github\_pat\_token](#input\_github\_pat\_token) | Github Personal Access Token (Sensitive). Please don't hardcode this in the repository. | `string` | n/a | yes |
| <a name="input_github_repository_name"></a> [github\_repository\_name](#input\_github\_repository\_name) | Github repository name that the self hosted runners can register themselves. | `string` | n/a | yes |
| <a name="input_github_runner_cpu"></a> [github\_runner\_cpu](#input\_github\_runner\_cpu) | CPU size for the self hosted runners. | `number` | `0.25` | no |
| <a name="input_github_runner_memory"></a> [github\_runner\_memory](#input\_github\_runner\_memory) | Memory size in Gib for the self hosted runners. | `number` | `0.5` | no |
| <a name="input_github_runners_image"></a> [github\_runners\_image](#input\_github\_runners\_image) | Runner container image used in azure container apps jobs. | `string` | `"pklaudat/github-actions"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location where to host the self hosted runners in azure. | `string` | n/a | yes |

<!-- END_TF_DOCS -->