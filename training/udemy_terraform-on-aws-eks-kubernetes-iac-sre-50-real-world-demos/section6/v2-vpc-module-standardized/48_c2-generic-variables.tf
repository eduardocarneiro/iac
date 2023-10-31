# Input Variables

# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "sa-east-1"  
}

# Environment Variable
variable "environment" {
  description = "Environment variable used as a prefix"
  type = string
  default = "dev"
}

# Business Division
variable "business_division" {
  description = "Business division"
  type = string
  default = "SAP"
  
}