resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.smarla.id}"
  count = "${length(split(",", var.azs))}"
  cidr_block = "${element(split (",", var.private_subnet_cidr), count.index)}"
  availability_zone = "${element(split (",", var.azs) ,count.index)}"

  tags {
    Name = "${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Group = "network"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.smarla.id}"

  tags {
    Name = "${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Group = "routing"
  }
}

resource "aws_route" "private_internet" {
  route_table_id = "${aws_route_table.private.id}"
  nat_gateway_id = "${aws_nat_gateway.default.id}"
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private" {
  count = "${length(split(",",var.azs))}"
  subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}
