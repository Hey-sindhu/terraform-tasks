# Creating the resource group
resource "azurerm_resource_group" "sindhu_resource_group" {
  name     = "tfC_resources"
  location = "East US 2"
}

#Creating a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "tfC_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.sindhu_resource_group.location
  resource_group_name = azurerm_resource_group.sindhu_resource_group.name
}

# Creating a Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "tfC_subnet"
  resource_group_name  = azurerm_resource_group.sindhu_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

