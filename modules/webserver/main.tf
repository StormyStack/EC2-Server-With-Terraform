resource "aws_default_security_group" "default-sg" {
  vpc_id = var.vpc_id
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
    values = [var.image_name]
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
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_default_security_group.default-sg.id]
  availability_zone           = var.availability_zones
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name
  user_data                   =file("entrypoint.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}
