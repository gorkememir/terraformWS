resource "aws_route53_zone" "gorkememir" {
  # (resource arguments)
}

resource "aws_route53_record" "terraform" {
  zone_id = "${aws_route53_zone.gorkememir.zone_id}"
  name    = "terraform.gorkememir.com"
  type    = "A"

  alias {
    name                   = "${aws_elb.tfELB.dns_name}"
    zone_id                = "${aws_elb.tfELB.zone_id}"
    evaluate_target_health = true
  }
}
