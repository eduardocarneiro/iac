# Terraform block
terraform {
  #required_version = "~> 0.14.8" --- allow: 0.14.9, 0.14.10 - deny: 0.15.x
  #required_version = "~> 0.14"   --- allow: 0.14.x, 0.15.x, 0.16.x - deny: 1.x.x
  required_version = "~> 1.4"
  required_providers {
    aws = {
     source = "hashicorp/aws"
     version = "~> 5.0"
    }
  }
}

# Provider block
provider "aws" {
  region = "sa-east-1"
}

/*
Note-1: AWS credentials profile (profile = "default") configured on your local desktop terminal
$HOME/.aws/credentials

Press 'Ctrl+space' to see the options of the terraform resource

Ref.: 
https://github.com/stacksimplify/terraform-on-aws-ec2/tree/main/03-Terraform-Settings-Providers-Resources
*/
