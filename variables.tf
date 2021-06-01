variable "algorithm" {
  description = "The name of the algorithm to use for the key. Currently-supported values are \"RSA\" and \"ECDSA\"."
  type = string
}

variable "rsa_bits" {
  description = "When algorithm is \"RSA\", the size of the generated RSA key in bits. Defaults to 2048."
  type = number
  default = 2048
}

variable "ecdsa_curve" {
  description = "When algorithm is \"ECDSA\", the name of the elliptic curve to use. May be any one of \"P224\", \"P256\", \"P384\" or \"P521\", with \"P224\" as the default."
  type = string
  default = "P224"
}

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
}

variable "subnet_id" {
  description = "The subnet to associate the client VPN with"
}

variable "cloudwatch_log_group" {
  description = "The CloudWatch log group to create"
}

variable "cloudwatch_log_stream" {
  description = "The CloudWatch log stream to create"
}

variable "custom_security_groups" {
  description = "A list of up to five custom security groups to apply to the target network. If not specified, the VPC's default security group is assigned."
  default = []
}
