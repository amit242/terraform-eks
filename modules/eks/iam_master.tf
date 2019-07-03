# Setup for IAM role needed to setup an EKS cluster
resource "aws_iam_role" "amit-eks-master" {
  name = "${var.cluster_name}-master"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = {
    Name = "${var.cluster_name}-master"
    Owner = "${var.owner}"
  }
}

resource "aws_iam_role_policy_attachment" "amit-eks-master-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.amit-eks-master.name}"
}

resource "aws_iam_role_policy_attachment" "amit-eks-master-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.amit-eks-master.name}"
}

