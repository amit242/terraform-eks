data "aws_acm_certificate" "amit-eks" {
  domain   = "*.${var.hosted_zone_url}"
  statuses = ["ISSUED"]
}