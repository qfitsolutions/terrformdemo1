terraform {
  backend "azurerm" {
    resource_group_name  = "StorageAccount-ResourceGroup"
    storage_account_name = "tfstatefordevstage2804"
    container_name       = "tfstate"
    key                  = "AKS/dev/terraform.tfstate"
  }
}
