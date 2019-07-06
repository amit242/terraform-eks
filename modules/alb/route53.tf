resource "aws_route53_record" "amit-eks" {
  zone_id = "${var.hosted_zone_id}"
  name    = "*.${var.cluster_name}.${var.hosted_zone_url}"
  type    = "A"
  alias {
    name                   = "${aws_alb.amit-eks-alb.dns_name}"
    zone_id                = "${aws_alb.amit-eks-alb.zone_id}"
    evaluate_target_health = false
  }
}