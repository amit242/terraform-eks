resource "aws_route_table" "gateway" {
  vpc_id = "${aws_vpc.amit-eks.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.amit-eks.id}"
  }
  tags = {
    Name = "${var.cluster_name}-gateway"
    Owner = "${var.owner}"
  }
}
resource "aws_route_table" "public" {
  count = "${var.subnet_count}"
  vpc_id = "${aws_vpc.amit-eks.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.amit-eks.*.id[count.index]}"
  }
  tags = {
    Name = "${var.cluster_name}-public-${count.index}"
    Owner = "${var.owner}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.amit-eks.id}"

  tags = {
    Name = "${var.cluster_name}-private"
    Owner = "${var.owner}"
  }
}

resource "aws_route_table_association" "gateway" {
  count = "${var.subnet_count}"

  subnet_id      = "${aws_subnet.gateway.*.id[count.index]}"
  route_table_id = "${aws_route_table.gateway.id}"
}
resource "aws_route_table_association" "public" {
  count = "${var.subnet_count}"

  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.*.id[count.index]}"
}
/* resource "aws_route_table_association" "public_secondary" {
  count = "${var.subnet_count}"

  subnet_id      = "${aws_subnet.public_secondary.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.*.id[count.index]}"
} */

resource "aws_route_table_association" "private" {
  count = "${var.subnet_count}"

  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.id}"
}
