########################################################################################
# Setup IAM role & instance profile for worker nodes

resource "aws_iam_role" "amit-eks-worker" {
  name = "${var.cluster_name}-worker"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  
  tags = {
    Name = "${var.cluster_name}-worker"
    Owner = "${var.owner}"
  }
}

resource "aws_iam_role_policy_attachment" "amit-eks-worker-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.amit-eks-worker.name}"
}

resource "aws_iam_role_policy_attachment" "amit-eks-worker-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.amit-eks-worker.name}"
}

resource "aws_iam_role_policy_attachment" "amit-eks-worker-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.amit-eks-worker.name}"
}

resource "aws_iam_instance_profile" "worker" {
  name = "amit-eks-worker"
  role = "${aws_iam_role.amit-eks-worker.name}"
}
