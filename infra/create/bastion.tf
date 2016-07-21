resource "aws_instance" "bastion" {
  ami = "${var.bastion_ami}"
  instance_type = "${var.bastion_instance_type}"

  subnet_id = "${aws_subnet.public.0.id}"
  availability_zone = "${element(split(",", var.azs), 0)}"
  key_name = "${aws_key_pair.bastion.key_name}"

  private_dns = "bastion-${var.environment}"
  private_ip = "${var.bastion_private_ip}"

  vpc_security_group_ids = [ "${aws_security_group.bastion.id}" ]

  tags {
    Name = "${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Group = "security"
  }
}

resource "aws_security_group" "bastion" {
  name = "bastion-${var.environment}"
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

resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  vpc      = true
}

resource "aws_route53_record" "bastion" {
  zone_id = "${aws_route53_zone.smarla-public.zone_id}"
  name = "bastion"
  type = "A"
  ttl = "300"
  records = ["${aws_eip.bastion.public_ip}"]
}