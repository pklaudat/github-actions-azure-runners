
variable "location" {
  type = string
}

variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/22"]
}
