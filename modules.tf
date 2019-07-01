module "network" {
  source = "./modules/network"

  // pass variables from .tfvars
  owner            = "${var.owner}"
  subnet_count     = "${var.subnet_count}"
  cluster_name     = "${var.cluster_name}"
}

module "security_groups" {
  source = "./modules/security_groups"

  // pass variables from .tfvars
  owner            = "${var.owner}"
  accessing_computer_ip   = "${var.accessing_computer_ip}"
  cluster_name     = "${var.cluster_name}"

  // inputs from other modules
  vpc_id                  = "${module.network.vpc_id}"
}