terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" 
    }
  }

  required_version = ">= 1.0"
}

provider "azurerm" {
  features {}

  subscription_id = "a0c353b6-cb40-4e36-a692-5ce1da78943d"
}
