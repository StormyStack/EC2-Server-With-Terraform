output "ami_id" {
  value = data.aws_ami.LatestUbuntu.id
}

output "public_ip" {
  value = aws_instance.myapp-server.public_ip 
}