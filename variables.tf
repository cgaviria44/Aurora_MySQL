variable "name" {}
variable "region" {}
variable "profile" {}
variable "Environment" {}
variable "vpc_id" {}
variable "instance_type" {}
variable "vpc_rds_subnet_ids" {}
variable "sg" {}
variable "username" {
    description = "The username for the DB master user"
    type        = string
    sensitive = true
}
variable "password" {
    description = "The password for the DB master user"
    type        = string
    sensitive = true
}