resource "aws_route53_zone" "smarla-public" {
  name = "smarla.com."

  tags {
    Name = "${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Group = "routing"
  }
}

resource "aws_route53_zone" "smarla-private" {
  name = "smarla.com."
  vpc_id = "${aws_vpc.smarla.id}"

  tags {
    Name = "${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Group = "routing"
  }
}

resource "aws_route53_zone" "pesama" {
  name = "pesama.org."

  tags {
    Name = "pesama-${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Group = "routing"
  }
}

resource "aws_route53_zone" "pandora" {
  name = "pandora.ninja."

  tags {
    Name = "pandora-${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Group = "routing"
  }
}