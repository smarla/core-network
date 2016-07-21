resource "aws_elb" "default" {
  name = "balancer-${var.component}-${var.environment}"
  availability_zones = ["${split(",", var.azs)}"]

  access_logs {
    bucket = "foo"
    bucket_prefix = "bar"
    interval = 60
  }

  listener {
    instance_port = 8000
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port = 8000
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "${var.smarla_ssl_certificate_arn}"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:8000/"
    interval = 30
  }

  instances = ["${aws_instance.app.id}"]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "${var.component}-${var.environment}"
    Environment = "${var.environment}"
    Component = "${var.component}"
    Group = "routing"
  }
}