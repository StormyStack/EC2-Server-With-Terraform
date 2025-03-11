variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
}

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