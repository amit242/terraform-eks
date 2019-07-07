########################################################################################
# Setup AutoScaling Group for worker nodes

# Setup data source to get amazon-provided AMI for EKS nodes
data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.amit-eks.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encode this
# information and write it into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  amit-eks-worker-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.amit-eks.endpoint}' --b64-cluster-ca '${aws_eks_cluster.amit-eks.certificate_authority.0.data}' '${var.cluster_name}'
USERDATA
}

resource "aws_launch_configuration" "amit-eks" {
  associate_public_ip_address = false
  iam_instance_profile        = "${aws_iam_instance_profile.worker.name}"
  image_id                    = "${data.aws_ami.eks-worker.id}"
  instance_type               = "${var.worker_instance_type}"
  name_prefix                 = "${var.cluster_name}"
  security_groups             = ["${var.worker_security_group_id}"]
  user_data_base64            = "${base64encode(local.amit-eks-worker-userdata)}"
  key_name                    = "${var.keypair_name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "amit-eks" {
  name = "${var.cluster_name}-workers"
  port = 31742
  protocol = "HTTP"
  vpc_id = "${var.vpc_id}"
  target_type = "instance"
}

resource "aws_autoscaling_group" "amit-eks" {
  desired_capacity     = 1
  launch_configuration = "${aws_launch_configuration.amit-eks.id}"
  max_size             = 4
  min_size             = 1
  name                 = "${var.cluster_name}-asg"
  vpc_zone_identifier  = "${var.public_subnet_ids}"
  target_group_arns    = ["${aws_lb_target_group.amit-eks.arn}"]

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Owner"
    value               = "${var.owner}"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
}
