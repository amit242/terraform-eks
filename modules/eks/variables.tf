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

variable "app_subnet_ids" {
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
