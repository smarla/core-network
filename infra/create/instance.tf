resource "aws_instance" "app" {
  ami = "${var.app_ami}"
  instance_type = "${var.app_instance_type}"

  subnet_id = "${aws_subnet.public.0.id}"
  availability_zone = "${element(split(",", var.azs), 0)}"
  key_name = "${aws_key_pair.app.key_name}"

  private_dns = "app-${var.environment}"
  private_ip = "${var.app_private_ip}"

  vpc_security_group_ids = [ "${aws_security_group.app.id}" ]

  tags {
    Name = "${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Group = "security"
  }
}

resource "aws_security_group" "app" {
  name = "app-${var.environment}"
  description = "Bastion security group for environment ${var.environment}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "app" {
  instance = "${aws_instance.app.id}"
  vpc      = true
}

resource "aws_route53_record" "app" {
  zone_id = "${aws_route53_zone.smarla-public.zone_id}"
  name = "app"
  type = "A"
  ttl = "300"
  records = ["${aws_eip.app.public_ip}"]
}