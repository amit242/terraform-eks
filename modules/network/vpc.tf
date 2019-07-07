resource "aws_vpc" "amit-eks" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.cluster_name}-vpc"
    Owner = "${var.owner}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}