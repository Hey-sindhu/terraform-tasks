# Creating the resource group
resource "azurerm_resource_group" "sindhu_resource_group" {
  name     = "tf_resources"
  location = "East US 2"
}

#Creating a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "tf_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.sindhu_resource_group.location
  resource_group_name = azurerm_resource_group.sindhu_resource_group.name
}

# Creating a Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "tf_subnet"
  resource_group_name  = azurerm_resource_group.sindhu_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

#Creating Public ip address
resource "azurerm_public_ip" "public_ip" {
  name                = "tf_public_ip"
  location            = azurerm_resource_group.sindhu_resource_group.location
  resource_group_name = azurerm_resource_group.sindhu_resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Creating a Network interface
resource "azurerm_network_interface" "nic" {
  name                = "tf_nic"
  location            = azurerm_resource_group.sindhu_resource_group.location
  resource_group_name = azurerm_resource_group.sindhu_resource_group.name

  ip_configuration {
    name                          = "tf_ip_configuration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"                         
    public_ip_address_id          = azurerm_public_ip.public_ip.id 
  }
}


