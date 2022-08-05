terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.16.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "RG-tbarakidotnet"
    storage_account_name  = "tfstatetbarakidotnet"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
}

resource "azurerm_static_site" "tbarakidotnet" {
  name                = "tbarakidotnet"
  resource_group_name = "RG-tbarakidotnet"
  location            = "central US"
  sku_tier            = "Free"
}

resource "azurerm_static_site" "tbarakidotnet-resume" {
  name                = "tbarakidotnet-resume"
  resource_group_name = "RG-tbarakidotnet"
  location            = "central US"
  sku_tier            = "Free"
}