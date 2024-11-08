# Creating the resource group
resource "azurerm_resource_group" "sindhu_resource_group" {
  name     = "tf_Container_resources"
  location = "East US 2"
}

resource "azurerm_container_registry" "con_reg" {
  name                = "sindhuTfconreg"
  resource_group_name = azurerm_resource_group.sindhu_resource_group.name
  location            = azurerm_resource_group.sindhu_resource_group.location
  sku                 = "Premium"
  admin_enabled       = true
}

output "adminpwd" {
  value = azurerm_container_registry.con_reg.admin_password
  sensitive=true
}

