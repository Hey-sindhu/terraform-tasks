terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.6.0"
    }
  }
}

provider "azurerm" {
  features {}

  client_id          = "fd8c0446-66c9-49b7-9bb5-dc0f60410f1c"
  client_secret       = "Qa_8Q~B9sEwj_WEWsIRBykWpszE9zlsR~tB5HaNI"
  tenant_id          = "f3930d54-83fc-480b-ab24-6024c03077bc"
subscription_id = "13b6aef3-d469-4b0b-9d19-5d5bcab6fb45"

}

