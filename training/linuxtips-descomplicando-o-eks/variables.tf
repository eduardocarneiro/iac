variable "vpc_name" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "eip_name" {
  type = string
}

variable "ngw_name" {
  type = string
}

variable "rtb_name" {
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


variable "private_subnets" {
  description = "List of Private subnets"
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
}