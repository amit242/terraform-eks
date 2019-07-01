data "aws_availability_zones" "available" {}

resource "aws_subnet" "gateway" {
  count = "${var.subnet_count}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.1${count.index}.0/24"
  vpc_id            = "${aws_vpc.amit-eks.id}"
  tags = {
    Name = "${var.cluster_name}-gateway-${count.index}"
    Owner = "${var.owner}"
  }
}
resource "aws_subnet" "public" {
  count = "${var.subnet_count}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.2${count.index}.0/24"
  vpc_id            = "${aws_vpc.amit-eks.id}"
  tags = {
    Name = "${var.cluster_name}-public-${count.index}"
    Owner = "${var.owner}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "private" {
  count = "${var.subnet_count}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.3${count.index}.0/24"
  vpc_id            = "${aws_vpc.amit-eks.id}"
  
  tags = {
    Name = "${var.cluster_name}-private-${count.index}"
    Owner = "${var.owner}"
  }
}