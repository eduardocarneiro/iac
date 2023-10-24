# terraform settings block
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}

# provider block
provider "aws" {
    profile = "default"
    region = "sa-east-1"
}

# resource block
resource "aws_instance" "ec2demo" {
  ami           = "ami-09cb7eeabc9707636"
  instance_type = "t2.micro"
}