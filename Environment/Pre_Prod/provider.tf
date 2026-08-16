terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.77.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "370b2d3a-e01b-4f6f-8d7c-760f75894068"
}