output "eks_kubeconfig" {
  value = "${local.kubeconfig}"
  depends_on = [
    "aws_eks_cluster.amit-eks"
  ]
}

output "lb_target_group_arn" {
  value = "${aws_lb_target_group.amit-eks.arn}"
}