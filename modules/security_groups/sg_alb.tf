resource "aws_security_group" "eks-alb" {
  name        = "${var.cluster_name}-alb"
  description = "Security group allowing public traffic for the eks load balancer."
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.cluster_name}-alb"
    Owner = "${var.owner}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

