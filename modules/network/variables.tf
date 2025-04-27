
variable "location" {
  description = "Location for the network resources."
  type        = string
}

variable "address_space" {
  type        = list(string)
  description = "The address space for the virtual network."
  default     = ["10.0.0.0/22"]
}

variable "route_to_firewall" {
  type        = bool
  default     = false
  description = "The route to the firewall. If not provided, the default route will be used."
}


variable "firewall_private_ip" {
  type        = string
  default     = null
  description = "The private IP address of the firewall."
}