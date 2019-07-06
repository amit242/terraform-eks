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

/* resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = "${aws_vpc.amit-eks.id}"
  cidr_block = "100.64.0.0/16"
} */