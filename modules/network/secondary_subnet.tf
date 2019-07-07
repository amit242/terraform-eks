/* resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = "${aws_vpc.amit-eks.id}"
  cidr_block = "100.64.0.0/16"
} */

/* resource "aws_subnet" "public_secondary" {
  count = "${var.subnet_count}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "100.64.${count.index}.0/24"
  vpc_id            = "${aws_vpc.amit-eks.id}"
  tags = {
    Name = "${var.cluster_name}-public_secondary-${count.index}"
    Owner = "${var.owner}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
} */

/* resource "aws_route_table_association" "public_secondary" {
  count = "${var.subnet_count}"

  subnet_id      = "${aws_subnet.public_secondary.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.*.id[count.index]}"
} */