variable "owner" {
  default = "Amit"
  type    = "string"
  description = "Owner of the resources"
}
variable "aws_region" {
    type = "string"
    description = "Used AWS Region"
}
variable "aws_credentials_file" {
    type = "string"
    description = "The credentials file for terraform client to access AWS"
}
variable "subnet_count" {
    type = "string"
    description = "The number of subnets we want to create per type to ensure high availability"
}
variable "cluster_name" {
  default = "amit-eks-demo"
  type    = "string"
  description = "name of the eks cluster"
}
variable "accessing_computer_ip" {
 type = "string"
 description = "IP of the computer to be allowed to connect to EKS master and nodes."
}
variable "worker_instance_type" {
  type = "string"
  description = "Type of worker node instance"
}
variable "keypair_name" {
  type = "string"
}
