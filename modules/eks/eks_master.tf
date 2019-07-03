resource "aws_eks_cluster" "amit-eks" {
  name = "${var.cluster_name}"
  role_arn        = "${aws_iam_role.amit-eks-master.arn}"

  vpc_config {
    security_group_ids = ["${var.master_security_group_id}"]
    subnet_ids         = "${var.app_subnet_ids}"
  }

  depends_on = [
    "aws_iam_role_policy_attachment.amit-eks-master-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.amit-eks-master-AmazonEKSServicePolicy"
  ]
}