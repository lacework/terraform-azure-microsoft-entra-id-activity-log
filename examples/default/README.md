# Example

Integrate monitoring of EntraId diagnostic logs.

```hcl
# versions.tf
terraform {
  required_providers {
    lacework = {
      source  = "lacework/lacework"
      version = "~> 1.6"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.25"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.45"
    }
  }
}

# providers.tf
provider "lacework" {
}

provider "azuread" {
}

provider "azurerm" {
  features {}
}

# main.tf
module "az_ad_application" {
  source  = "lacework/ad-application/azure"
  version = "~> 1.3.0"
}

module "microsoft-entra-id-activity-log" {
  source = "lacework/microsoft-entra-id-activity-log/azure"
  version = "~> 0.2.0"
  use_existing_ad_application = true

  application_id              = module.az_ad_application.application_id
  application_password        = module.az_ad_application.application_password
  service_principal_id        = module.az_ad_application.service_principal_id
}
```
