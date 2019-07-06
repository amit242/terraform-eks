resource "aws_security_group_rule" "alb-public-https" {
  description       = "Allow eks load balancer to communicate with public traffic securely."
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.eks-alb.id}"
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "alb-public-http" {
  description       = "Allow eks load balancer to communicate with public traffic."
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.eks-alb.id}"
  to_port           = 80
  type              = "ingress"
}