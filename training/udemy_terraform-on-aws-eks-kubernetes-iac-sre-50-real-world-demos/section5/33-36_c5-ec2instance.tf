# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amz_linux2.id
  instance_type = var.ec2_instance_type
  #instance_type = var.ec2_instance_type_list[1] # for List
  #instance_type = var.ec2.instance_type_map["prd"] # for map
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.ec2_instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc-sg-ssh.id, aws_security_group.vpc-sg-web.id ]
  # Create EC2 Instance in all Availability Zones of a VPC
  for_each = toset(keys({for az, details in data.aws_ec2_instance_type_offerings.my_instance_type: 
    az => details.instance_types if length(details.instance_types) != 0}))
  availability_zone = each.key  # You can also use each.value because for list items each.key == each.value
  // count = 2
  tags = {
    "Name" = "EC2 Demo-${each.value}"
  }
}