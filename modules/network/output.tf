output "vpc_id" {
  value = "${aws_vpc.amit-eks.id}"
}
output "gateway_subnet_ids" {
  value = "${aws_subnet.gateway.*.id}"
}
output "public_subnet_ids" {
  value = "${aws_subnet.public.*.id}"
}