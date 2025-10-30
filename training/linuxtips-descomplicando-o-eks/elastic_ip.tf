resource "aws_eip" "eip" {
  count = length(var.public_subnets)

  domain = "vpc"
  tags = {
    Name = format("%s-$s", var.eip_name, var.public_subnets[count.index].availability_zone)
  }
}