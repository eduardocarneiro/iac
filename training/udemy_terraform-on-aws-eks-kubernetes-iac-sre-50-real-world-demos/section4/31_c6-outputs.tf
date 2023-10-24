# Terraform Output values

# EC2 Instance Public IP
output "ec2_instance_publicip" {
    description = "EC2 Instance public IP"
    value = aws_instance.myec2vm.public_ip
}

# EC2 Instance Public DNS
output "ec2_instance_publicdns" {
    description = "EC2 Instance public DNS"
    value = aws_instance.myec2vm.public_dns
  
}