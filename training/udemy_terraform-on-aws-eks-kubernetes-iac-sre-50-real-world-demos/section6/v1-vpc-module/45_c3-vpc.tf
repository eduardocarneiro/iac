# Create VPC Terraform Module
/*
ref.: 
https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
  --> Example (complete) --- https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest?tab=inputs
    --> click (source code) --- https://github.com/terraform-aws-modules/terraform-aws-vpc/tree/v5.1.2/examples/complete
*/
module "eoc-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  # VPC Basic details
  name              = "vpc-dev"
  cidr              = "10.0.0.0/16"
  azs               = [ "sa-east-1a", "sa-east-1b" ]
  private_subnets   = [ "10.0.1.0/24", "10.0.2.0/24" ]
  public_subnets    = [ "10.0.101.0/24", "10.0.102.0/24"]

  # Database subnets
  create_database_subnet_group = true
  create_database_subnet_route_table = true
  database_subnets  = [ "10.0.151.0/24", "10.0.152.0/24"]

  # NAT Gateway - outbound 
  enable_nat_gateway = true
  single_nat_gateway = true

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    Name = "public-subnets"

  }

  private_subnet_tags = {
    Name = "private-subnets"
    
  }

  database_subnet_tags = {
    Name = "database-subnets"
    
  }

  tags = {
    Owner = "EOC"
    Environment = "DEV"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }

}



