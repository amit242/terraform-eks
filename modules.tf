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
  owner                   = "${var.owner}"
  accessing_computer_ip   = "${var.accessing_computer_ip}"
  cluster_name            = "${var.cluster_name}"

  // inputs from other modules
  vpc_id                  = "${module.network.vpc_id}"
}

module "eks" {
  source = "./modules/eks"

  // pass variables from .tfvars
  owner                     = "${var.owner}"
  cluster_name              = "${var.cluster_name}"
  keypair_name              = "${var.keypair_name}"
  worker_instance_type      = "${var.worker_instance_type}"
  // inputs from modules
  vpc_id                    = "${module.network.vpc_id}"
  public_subnet_ids         = "${module.network.public_subnet_ids}"
  master_security_group_id  = "${module.security_groups.master_security_group_id}"
  worker_security_group_id  = "${module.security_groups.worker_security_group_id}"
}
module "alb" {
  source = "./modules/alb"

  // pass variables from .tfvars
  owner                    = "${var.owner}"
  cluster_name             = "${var.cluster_name}"
  hosted_zone_id           = "${var.hosted_zone_id}"
  hosted_zone_url          = "${var.hosted_zone_url}"
  // inputs from modules
  gateway_subnet_ids        = "${module.network.gateway_subnet_ids}"
  lb_target_group_arn       = "${module.eks.lb_target_group_arn}"
  worker_security_group_id  = "${module.security_groups.worker_security_group_id}"
  alb_security_group_id     = "${module.security_groups.alb_security_group_id}"
}