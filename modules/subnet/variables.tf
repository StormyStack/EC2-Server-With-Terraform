variable "subnet_cidr_blocks" {
  description = "The CIDR blocks for the subnets."
  type        = string
}

variable "availability_zones" {
  description = "The availability zones for the subnets."
  type        = string
}

variable "env_prefix" {
  description = "The prefix for the environment."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "default_route_table_id" {
  description = "The ID of the default route table."
  type        = string
}