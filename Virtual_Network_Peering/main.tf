resource "azurerm_resource_group" "rg" {
  name     = "demo_rg"
  location = "West Europe"
}
resource "azurerm_virtual_network" "vnet-1" {
  name                = "vnet1"
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.1.0/16"]
  location            = azurerm_resource_group.example.location
}

resource "azurerm_virtual_network" "vnet-2" {
  name                = "vnet2"
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.2.0/16"]
  location            = azurerm_resource_group.example.location
}

resource "azurerm_virtual_network_peering" "peering-1" {
  name                      = "vnet1-to-vnet2"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet-1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-2.id
}

resource "azurerm_virtual_network_peering" "peering-2" {
  name                      = "vnet2-to-vnet1"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet-2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-1.id
}