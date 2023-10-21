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
}

provider "aws" {
    region = "sa-east-1"
}