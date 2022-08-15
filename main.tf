terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.16.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">=3.21.0"
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
  features {}
}

provider "cloudflare" {
  api_token = data.azurerm_key_vault_secret.cf_token.value
}

// Read Cloudflare API token from Azure Key Vault
data "azurerm_key_vault" "key_vault" {
  name                = "TGBProjectKeys"
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "cf_token" {
  name         = "Cloudflare"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

// Define static web appps in a resource group
resource "azurerm_resource_group" "tbarakidotnet" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_static_site" "tbarakidotnet" {
  name                = "tbarakidotnet"
  resource_group_name = azurerm_resource_group.tbarakidotnet.name
  location            = var.location
  sku_tier            = var.sku_tier
}

resource "azurerm_static_site" "tbarakidotnet_resume" {
  name                = "tbarakidotnet-resume"
  resource_group_name = azurerm_resource_group.tbarakidotnet.name
  location            = var.location
  sku_tier            = var.sku_tier
}

// Define Cloudflare DNS records
resource "cloudflare_record" "root" {
  zone_id = var.tbarakidotnet_zone_id
  name    = "tbaraki.net"
  value   = resource.azurerm_static_site.tbarakidotnet.default_host_name
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = var.tbarakidotnet_zone_id
  name    = "www"
  value   = resource.azurerm_static_site.tbarakidotnet.default_host_name
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "resume" {
  zone_id = var.tbarakidotnet_zone_id
  name    = "resume"
  value   = resource.azurerm_static_site.tbarakidotnet_resume.default_host_name
  type    = "CNAME"
  ttl     = 1
  proxied = true
}