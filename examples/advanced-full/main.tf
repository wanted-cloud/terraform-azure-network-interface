
resource "azurerm_virtual_network" "this" {
  name                = "vnet-advanced-full-example"
  address_space       = ["172.16.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_subnet" "primary" {
  name                 = "subnet-primary"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["172.16.1.0/24"]

  depends_on = [azurerm_virtual_network.this]
}

resource "azurerm_subnet" "secondary" {
  name                 = "subnet-secondary"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["172.16.2.0/24"]

  depends_on = [azurerm_virtual_network.this]
}

resource "azurerm_public_ip" "this" {
  name                = "pip-advanced-full-example"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                = "Standard"

  depends_on = [azurerm_resource_group.this]
}

module "network_interface" {
  depends_on = [
    azurerm_resource_group.this, 
    azurerm_subnet.primary, 
    azurerm_subnet.secondary,
    azurerm_public_ip.this
  ]
  source = "../.."
  
  name                = "nic-advanced-full-example"
  resource_group_name = azurerm_resource_group.this.name
  location           = azurerm_resource_group.this.location

  accelerated_networking_enabled = true  
  ip_forwarding_enabled         = true    
  dns_servers                  = ["1.1.1.1", "1.0.0.1", "8.8.8.8"]
  internal_dns_name_label      = "nic-advanced-full-internal"
  auxiliary_mode               = "None"
  auxiliary_sku                = "None"
  edge_zone                    = ""

  ip_configurations = [
    {
      name                         = "primary"
      subnet_id                   = azurerm_subnet.primary.id
      private_ip_address_allocation = "Static"
      private_ip_address          = "172.16.1.10"
      private_ip_address_version   = "IPv4"
      public_ip_address_id        = azurerm_public_ip.this.id
      primary                     = true
    },
    {
      name                         = "secondary"
      subnet_id                   = azurerm_subnet.secondary.id
      private_ip_address_allocation = "Dynamic"
      private_ip_address_version   = "IPv4"
      public_ip_address_id        = ""
      primary                     = false
    },
    {
      name                         = "tertiary"
      subnet_id                   = azurerm_subnet.primary.id
      private_ip_address_allocation = "Static"
      private_ip_address          = "172.16.1.11"
      private_ip_address_version   = "IPv4"
      public_ip_address_id        = ""
      primary                     = false
    }
  ]

  tags = {
    Environment     = "AdvancedFull"
    Purpose         = "CompleteTesting"
    ManagedBy       = "Terraform"
    CostCenter      = "IT-Infrastructure"
    Owner           = "NetworkTeam"
    Project         = "NetworkInterfaceModule"
  }
}