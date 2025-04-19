terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.37.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=3.3.0"
    }
  }
}