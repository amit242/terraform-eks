output "vpc_id" {
  value = "${aws_vpc.amit-eks.id}"
}
output "app_subnet_ids" {
  value = "${aws_subnet.public.*.id}"
}