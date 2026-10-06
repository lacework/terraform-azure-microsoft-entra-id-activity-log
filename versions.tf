terraform {
  required_version = ">= 0.12.31"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.1"
    }
    random = ">= 2.1"
    lacework = {
      source  = "lacework/lacework"
      version = "~> 2.0"
    }
  }
}
