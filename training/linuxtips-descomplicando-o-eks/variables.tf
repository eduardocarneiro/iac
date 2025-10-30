variable "project_name" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "eip_name" {
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


variable "public_subnets" {
  description = "List of Public subnets"
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
}
