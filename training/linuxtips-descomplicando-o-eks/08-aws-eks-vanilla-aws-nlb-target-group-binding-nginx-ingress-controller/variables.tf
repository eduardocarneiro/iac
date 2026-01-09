variable "region" {
  type = string
}

variable "eks_name" {
  type = string
}

variable "ssm_vpc" {
  type = string
}

variable "ssm_public_subnets" {
  type = list(string)
}

variable "ssm_private_subnets" {
  type = list(string)
}

variable "ssm_pod_subnets" {
  type = list(string)
}

variable "kms_name" {
  type = string
}

variable "k8s_version" {
  type = string
}

variable "auto_scale_options" {
  type = object({
    min     = number
    max     = number
    desired = number
  })
}

variable "nodes_instance_sizes" {
  type = list(string)
}

variable "addon_cni_version" {
  type    = string
  default = "v1.20.4-eksbuild.2"
}

variable "addon_coredns_version" {
  type    = string
  default = "v1.11.3-eksbuild.1"
}

variable "addon_kubeproxy_version" {
  type    = string
  default = "v1.31.10-eksbuild.12"
}

variable "aws_lb_controller_name" {
  type = string
}

variable "aws_lb_policy_name" {
  type = string
}

variable "nlb_name" {
  type = string
}

variable "nlb_target_group_name" {
  type = string
}

variable "nginx_min_replicas" {
  type = string
}

variable "nginx_max_replicas" {
  type = string
}

variable "nginx_requets_cpu" {
  type = string
}

variable "nginx_request_memonry" {
  type = string
}

variable "nginx_limits_cpu" {
  type = string
}

variable "nginx_limits_memory" {
  type = string
}
