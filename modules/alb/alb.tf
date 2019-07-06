resource "aws_alb" "amit-eks-alb" {
  name            = "${var.cluster_name}"
  subnets         = "${var.gateway_subnet_ids}"
  security_groups = ["${var.worker_security_group_id}", "${var.alb_security_group_id}"]
  ip_address_type = "ipv4"

  tags = {
    Name = "${var.cluster_name}-alb"
    Owner = "${var.owner}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}
resource "aws_alb_listener" "eks-alb-http" {
  load_balancer_arn = "${aws_alb.amit-eks-alb.arn}"
  port              = 80
  protocol          = "HTTP"
  default_action {
    type              = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "eks-alb-https" {
  load_balancer_arn = "${aws_alb.amit-eks-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = "${data.aws_acm_certificate.amit-eks.arn}"
  default_action {
    type             = "forward"
    target_group_arn = "${var.lb_target_group_arn}"
  }
}