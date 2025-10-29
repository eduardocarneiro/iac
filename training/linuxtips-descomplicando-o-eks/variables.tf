variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_cidr" {
  type        = string
  description = "principal CIDR of VPC"
}

variable "vpc_additional_cidrs" {
  type        = list(string)
  description = "Additional VPC"
}