output "master_security_group_id" {
  value = "${aws_security_group.eks-master.id}"
}

output "worker_security_group_id" {
  value = "${aws_security_group.eks-worker.id}"
}
