terraform {
  backend "s3" {

  }

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.9.1"
    }
  }

}