variable "owner" {
  type    = "string"
  description = "Owner of the resources"
}
variable "cluster_name" {
  type    = "string"
  description = "name of the eks cluster"
}
variable "keypair_name" {
  type = "string"
}
variable "vpc_id" {
  type = "string"
  description = "ID of the VPC used to setup the cluster."
}
variable "public_subnet_ids" {
  type = "list"
}

variable "master_security_group_id" {
  type = "string"
}
variable "worker_security_group_id" {
  type = "string"
}

variable "worker_instance_type" {
  type = "string"
}
variable "worker_max_size" {
  type = "string"
  description = "Maximum number of worker node instances"
}
variable "worker_min_size" {
  type = "string"
  description = "Minimum number of worker node instances"
}
variable "worker_desired_size" {
  type = "string"
  description = "Desired number of worker node instances"
}

