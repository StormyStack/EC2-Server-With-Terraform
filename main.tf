terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.90.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myapp_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
} 

module "myapp-subnet" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.myapp_vpc.id
  env_prefix = var.env_prefix
  availability_zones = var.availability_zones
  subnet_cidr_blocks = var.subnet_cidr_blocks
  default_route_table_id = aws_vpc.myapp_vpc.default_route_table_id
}

module "myapp-server" {
  source = "./modules/webserver"
  vpc_id = aws_vpc.myapp_vpc.id
  env_prefix = var.env_prefix
  my-ip = var.my-ip
  public_key_location = var.public_key_location
  instance_type = var.instance_type
  availability_zones = var.availability_zones
  image_name = var.image_name
  subnet_id = module.myapp-subnet.subnet_id
}