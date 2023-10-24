# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amz_linux2.id
  instance_type = var.ec2_instance_type
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.ec2_instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc-sg-ssh.id, aws_security_group.vpc-sg-web.id ]
  tags = {
    "Name" = "EC2 Demo"
  }
}