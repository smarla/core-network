resource "aws_vpc" "smarla" {
  cidr_block = "${var.vpc_cidr_block}"
  enable_dns_hostnames  = "true"

  tags {
    Name = "${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Role = "network"
  }
}