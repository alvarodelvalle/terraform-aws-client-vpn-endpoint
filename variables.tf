variable "validity_period_hours" {
  description = "The number of hours after initial issuing that the certificate will become invalid. Default is 87600 (10 years)."
  type = number
  default = 87600
}

variable "prefix" {
  description = "Prefix to apply to resources"
}

variable "organization" {
  description = "The organization name to use for the private key"
  default = "DelvOps"
}

variable "cidr_block" {
  description = "The CIDR /32 block to associate the client VPN with."
  default = ""
}

