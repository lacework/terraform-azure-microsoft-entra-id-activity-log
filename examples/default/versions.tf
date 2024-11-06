terraform {
  required_providers {
    lacework = {
      source  = "lacework/lacework"
      version = "~> 2.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}