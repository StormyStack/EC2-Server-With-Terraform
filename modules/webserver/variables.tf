variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "my-ip" {
  description = "The IP address to allow SSH access."
  type        = string
}

variable "env_prefix" {
  description = "The prefix for the environment."
  type        = string
}

variable "public_key_location" {
  description = "The location of the public key."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the server."
  type        = string
}

variable "availability_zones" {
  description = "The availability zones for the subnets."
  type        = string
}

variable "image_name" {
  description = "The name of the image to use for the server."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet."
  type        = string
}
