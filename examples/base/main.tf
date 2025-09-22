resource "azurerm_resource_group" "this" {
  name     = "rg-nic-basic-example"
  location = "North Europe"
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-basic-example"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_subnet" "this" {
  name                 = "subnet-basic-example"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [azurerm_virtual_network.this]
}

module "network_interface" {
  depends_on = [azurerm_resource_group.this, azurerm_subnet.this]
  source = "../.."
  
  name                = "nic-basic-example"
  resource_group_name = azurerm_resource_group.this.name
  location           = azurerm_resource_group.this.location

  ip_configurations = [
    {
      name      = "primary"
      subnet_id = azurerm_subnet.this.id
      primary   = true
    }
  ]
}