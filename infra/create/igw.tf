resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.smarla.id}"

  tags {
    Name = "${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Group = "routing"
  }
}