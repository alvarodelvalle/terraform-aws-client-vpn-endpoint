variable "validity_period_hours" {
  description = "The number of hours after initial issuing that the certificate will become invalid."
  type = number
}

variable "prefix" {
  description = "Prefix to apply to resources"
}

variable "organization" {
  description = "The organization name to use for the private key"
  default = "DelvOps"
}
