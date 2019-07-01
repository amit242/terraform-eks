resource "aws_internet_gateway" "amit-eks" {
  vpc_id = "${aws_vpc.amit-eks.id}"

  tags = {
    Name = "${var.cluster_name}-igw"
    Owner = "${var.owner}"
  }
}
resource "aws_eip" "amit-eks" {
  count = "${var.subnet_count}"
  vpc      = true
  depends_on = ["aws_internet_gateway.amit-eks"]
  tags = {
    Name = "${var.cluster_name}-${count.index}-eip"
    Owner = "${var.owner}"
  }
}
resource "aws_nat_gateway" "amit-eks" {
  count = "${var.subnet_count}"
  allocation_id = "${aws_eip.amit-eks.*.id[count.index]}"
  subnet_id = "${aws_subnet.gateway.*.id[count.index]}"
  tags = {
    Name = "${var.cluster_name}-ng-${count.index}"
    Owner = "${var.owner}"
  }
  depends_on = ["aws_internet_gateway.amit-eks"]
}