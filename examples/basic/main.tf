locals {
  prefix = "devops"
  organization = "DelvOps"
}

provider "aws" {
  region = "us-east-1"
}

module "example" {
  source = "alvarodelvalle/terraform-aws-client-vpn-endpoint"
  algorithm = "RSA"
  validity_period_hours = 87600
  prefix = local.prefix
  organization = local.organization
  # existing VPC values
  cidr_block = "172.31.0.0/20"
  subnet_id = "subnet-1db6d67a"
  cloudwatch_log_group = "${local.organization}-${local.prefix}"
  cloudwatch_log_stream = "${local.prefix}-logs"
}
