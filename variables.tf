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

variable "my-ip" {
  description = "The IP address to allow SSH access."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
}

variable "public_key_location" {
  description = "The location of the public key."
  type        = string
}