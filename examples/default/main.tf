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
  version = "~> 2.0"
}

module "microsoft-entra-id-activity-log" {
  source = "../../"
  use_existing_ad_application = true

  application_id              = module.az_ad_application.application_id
  application_password        = module.az_ad_application.application_password
  service_principal_id        = module.az_ad_application.service_principal_id
}