# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources will be created"
  type = string
  default = "sa-east-1"
}


# AWS EC2 Instance Type
variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t2.small"
}


# AWS EC2 Instance Key Pair
variable "ec2_instance_keypair" {
    description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
    type = string
    default = "terraform-key1"
}

# section 5
# AWS EC2 Instance Type - List
variable "ec2_instance_type_list" {
  description = "EC Instance Type"
  type = list(string)
  default = [ "t2.micro", "t2.small" ]
}

# AWS EC2 Instance Type - Map
variable "ec2_instance_type_map" {
  description = "EC Instance Type"
  type = map(string)
  default = {
    "dev" = "t2.small"
    "qa"  = "t2.micro"
    "prd" = "t3.micro"
  }
}