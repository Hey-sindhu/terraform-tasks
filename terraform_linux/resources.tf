
# Creating linux virtual machine

# Creating the resource group
resource "azurerm_resource_group" "sindhu_resource_group" {
  name     = "terraform_Linux_resources"
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

#Creating Public ip address
resource "azurerm_public_ip" "public_ip" {
  name                = "tf_public_ip"
  location            = azurerm_resource_group.sindhu_resource_group.location
  resource_group_name = azurerm_resource_group.sindhu_resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = "tflinuxmachine"
  resource_group_name = azurerm_resource_group.sindhu_resource_group.name
  location            = azurerm_resource_group.sindhu_resource_group.location
  size                = "Standard_DS1_v2"
  admin_username      = "tf_user"

  admin_ssh_key {
    username   = "tf_user"
    public_key = file("~/.ssh/my_azure_key.pub")
  }

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

# Output the public IP address of the VM
output "public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

