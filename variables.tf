variable "name" {
  description = "Name of the Azure network interface resource."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which the Azure network interface will be created."
  type        = string
}

variable "location" {
  description = "Location of the resource group in which the Azure network interface will be created, if not set it will be the same as the resource group."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to be applied to the Azure network interface."
  type        = map(string)
  default     = {}
}

variable "auxiliary_mode" {
  description = "Auxiliary mode for the Azure network interface."
  type        = string
  default     = "None"
}

variable "auxiliary_sku" {
  description = "Auxiliary SKU for the Azure network interface."
  type        = string
  default     = "None"
}

variable "dns_servers" {
  description = "DNS servers for the Azure network interface."
  type        = list(string)
  default     = []
}

variable "edge_zone" {
  description = "Edge zone for the Azure network interface."
  type        = string
  default     = ""
}

variable "ip_forwarding_enabled" {
  description = "Enable IP forwarding for the Azure network interface."
  type        = bool
  default     = false
}

variable "accelerated_networking_enabled" {
  description = "Enable accelerated networking for the Azure network interface."
  type        = bool
  default     = false
}

variable "internal_dns_name_label" {
  description = "Internal DNS name label for the Azure network interface."
  type        = string
  default     = ""
}

variable "ip_configurations" {
  description = "IP configurations for the Azure network interface."
  type = list(object({
    name                                               = string
    subnet_id                                          = optional(string, "")
    gateway_load_balancer_frontend_ip_configuration_id = optional(string, "")
    private_ip_address_allocation                      = optional(string, "Dynamic")
    private_ip_address_version                         = optional(string, "IPv4")
    private_ip_address                                 = optional(string, "")
    public_ip_address_id                               = optional(string, "")
    primary                                            = optional(bool, false)
  }))
  default = []
}