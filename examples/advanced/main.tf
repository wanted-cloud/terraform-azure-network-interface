resource "azurerm_resource_group" "this" {
  name     = "rg-nic-advanced-example"
  location = "West Europe"
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-advanced-example"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_subnet" "this" {
  name                 = "subnet-advanced-example"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [azurerm_virtual_network.this]
}

module "network_interface" {
  depends_on = [azurerm_resource_group.this, azurerm_subnet.this]
  source     = "../.."

  name                = "nic-advanced-example"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  accelerated_networking_enabled = true
  ip_forwarding_enabled          = true
  dns_servers                    = ["8.8.8.8", "8.8.4.4"]
  internal_dns_name_label        = "nic-advanced-example"

  ip_configurations = [
    {
      name                          = "primary"
      subnet_id                     = azurerm_subnet.this.id
      private_ip_address_allocation = "Static"
      private_ip_address            = "10.0.1.10"
      private_ip_address_version    = "IPv4"
      primary                       = true
    }
  ]

  tags = {
    Environment = "Advanced"
    Purpose     = "Testing"
    ManagedBy   = "Terraform"
  }
}
