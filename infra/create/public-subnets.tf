resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.smarla.id}"
  count = "${length(split(",", var.azs))}"
  cidr_block = "${element(split (",", var.public_subnet_cidr), count.index)}"
  availability_zone = "${element(split (",", var.azs), count.index)}"

  tags {
    Name = "${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Group = "network"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.smarla.id}"

  tags {
    Name = "${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Group = "routing"
  }
}

resource "aws_route" "public_internet" {
  route_table_id = "${aws_route_table.public.id}"
  gateway_id = "${aws_internet_gateway.default.id}"
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public" {
  count = "${length(split(",", var.azs))}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
