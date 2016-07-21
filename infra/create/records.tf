resource "aws_route53_record" "smarla-root" {
  zone_id = "${aws_route53_zone.smarla-public.zone_id}"
  name = "smarla.com."
  type = "A"

  alias {
    name = "${aws_elb.default.dns_name}"
    zone_id = "${aws_elb.default.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "smarla-www" {
  zone_id = "${aws_route53_zone.smarla-public.zone_id}"
  name = "www"
  type = "CNAME"
  ttl = "3600"
  records = ["${aws_route53_record.smarla-root.fqdn}"]
}

resource "aws_route53_record" "smarla-mail" {
  zone_id = "${aws_route53_zone.smarla-public.zone_id}"
  name = "smarla.com."
  type = "MX"
  ttl = "3600"
  records = [] // TODO
}

resource "aws_route53_record" "pesama-root" {
  zone_id = "${aws_route53_zone.pesama.zone_id}"
  name = "pesama.org."
  type = "A"

  alias {
    zone_id = "${aws_route53_record.smarla-root.zone_id}"
    name = "${aws_route53_record.smarla-root.fqdn}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "pesama-www" {
  zone_id = "${aws_route53_zone.pesama.zone_id}"
  name = "www"
  type = "CNAME"
  ttl = "3600"
  records = ["${aws_route53_record.pesama-root.fqdn}"]
}

resource "aws_route53_record" "pandora-root" {
  zone_id = "${aws_route53_zone.pandora.zone_id}"
  name = "pandora.ninja."
  type = "A"

  alias {
    zone_id = "${aws_route53_record.smarla-root.zone_id}"
    name = "${aws_route53_record.smarla-root.fqdn}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "pandora-www" {
  zone_id = "${aws_route53_zone.pandora.zone_id}"
  name = "www"
  type = "CNAME"
  ttl = "3600"
  records = ["${aws_route53_record.pandora-root.fqdn}"]
}