########################################################################################
# setup provider for kubernetes
data "external" "aws_iam_authenticator" {
  program = ["sh", "-c", "aws-iam-authenticator token -i ${var.cluster_name} | jq -r -c .status"]
}

provider "kubernetes" {
  host                      = "${aws_eks_cluster.amit-eks.endpoint}"
  cluster_ca_certificate    = "${base64decode(aws_eks_cluster.amit-eks.certificate_authority.0.data)}"
  token                     = "${data.external.aws_iam_authenticator.result.token}"
  load_config_file          = false
  version = "~> 1.5"
}