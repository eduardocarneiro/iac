terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">=3.54.0"
        }
        local = {
            version = ">=2.1.0"
        }
    }
    backend "s3" {
        bucket  = "eoc-eks-bucket"
        key     = "terraform.tfstate"
        region  = "sa-east-1"
    }
}

provider "aws" {
    region = "sa-east-1"
}

module "eks-vpc" {
    source = "./modules/vpc"
    prefix = var.prefix
    vpc_cidr_block = var.vpc_cidr_block    
}

module "eks-cluster" {
    source = "./modules/eks"
    prefix = var.prefix
    vpc_id = module.eks-vpc.vpc_id
    cluster_name = var.cluster_name
    retention_days = var.retention_days
    subnet_ids = module.eks-vpc.subnet_ids
    desired_size = var.desired_size
    max_size = var.max_size
    min_size = var.min_size

}