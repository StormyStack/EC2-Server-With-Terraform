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

resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.myapp_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my-ip]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env_prefix}-default-sg"
  }
}

data "aws_ami" "LatestUbuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}



resource "aws_key_pair" "ssh-key" {
  key_name   = "myapp-key-pair"
  public_key = file(var.public_key_location)
}

resource "aws_instance" "myapp-server" {
  ami                         = data.aws_ami.LatestUbuntu.id
  instance_type               = var.instance_type
  subnet_id                   = module.myapp-subnet.subnet_id
  vpc_security_group_ids      = [aws_default_security_group.default-sg.id]
  availability_zone           = var.availability_zones
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name
  user_data                   =file("entrypoint.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}
