variable "owner" {
  type    = "string"
  description = "Owner of the resources"
}
variable "subnet_count" {
    type        = "string"
    description = "The number of subnets to ensure high availability"
}
variable "cluster_name" {
  type    = "string"
  description = "name of the eks cluster"
}