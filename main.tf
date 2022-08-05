terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.16.0"
    }
  }

  cloud {
    organization = "tbaraki"
    workspaces {
      name = "IaC-tbarakidotnet"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
}

resource "azurerm_static_site" "tbarakidotnet" {
  name                = "tbarakidotnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_tier            = var.sku_tier
}

resource "azurerm_static_site" "tbarakidotnet-resume" {
  name                = "tbarakidotnet-resume"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_tier            = var.sku_tier
}