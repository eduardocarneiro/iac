resource "aws_vpc" "eks_vpc" {
  cidr_block    = var.vpc_cidr_block

  tags = {
    Name = "${var.prefix}-EKS-VPC"
  }
}

resource "aws_internet_gateway" "eks-igw" {
    vpc_id = aws_vpc.eks_vpc.id
  
    tags = {
      Name = "${var.prefix}-igw"
    }
}

resource "aws_route_table" "eks-rtb" {
    vpc_id = aws_vpc.eks_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.eks-igw.id
    }
    tags = {
      Name = "${var.prefix}-rtb"
    }
}

resource "aws_route_table_association" "eks-rtb-association" {
    count = 2
    route_table_id = aws_route_table.eks-rtb.id
    subnet_id = aws_subnet.subnets.*.id[count.index]
}

data "aws_availability_zones" "get_az_available" {}
#output "show_az_available" {
#    value = data.aws_availability_zones.get_az_available.names[0]
#}

resource "aws_subnet" "subnets" {
    count = 2
    vpc_id      = aws_vpc.eks_vpc.id
    cidr_block  = "10.0.${count.index}.0/24"
    availability_zone = data.aws_availability_zones.get_az_available.names[count.index]
    tags = {
        Name = "${var.prefix}-Subnet-${count.index}"
    }
    map_public_ip_on_launch = true
}