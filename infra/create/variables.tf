variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-west-1"
}

variable "azs" {
  default = "eu-west-1a,eu-west-1b"
}

variable "component" {
  default = "core-network"
}

variable "environment" {
  default = "proton"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/8"
}

variable "private_subnet_cidr" {
  default = "10.254.0.0/24,10.254.1.0/24"
}

variable "public_subnet_cidr" {
  default = "10.0.0.0/24,10.0.1.0/24"
}

variable "db_engine_version" {}
variable "db_instance_class" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}

variable "bastion_ami" {}
variable "bastion_instance_type" {}
variable "bastion_private_ip" {}

variable "app_ami" {}
variable "app_instance_type" {}
variable "app_private_ip" {}

variable "smarla_ssl_certificate_arn" {}
