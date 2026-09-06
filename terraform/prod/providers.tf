terraform {
  required_version = ">= 1.9, < 2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4, <5"
    }
  }
  
  backend "azurerm" {
    use_azuread_auth     = true 
  }
}

provider "azurerm" {
  features {}
}
