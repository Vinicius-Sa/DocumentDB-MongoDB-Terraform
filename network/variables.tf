variable "default_tags" {
  type        = map
  default     = {}
  description = "Tags definition."
}
variable region {
  type = string
}

#Conexao VPC Peering
variable "peer_vpc_id" {
  default = ""
}

variable subnet_infra_legacy {
  type = string
  default = ""
}

variable "aws_service_security_group_ids" {
  type = list
  description = "The IDs from service security group to ingress on RDS/documentdb cluster."
}

variable "list_port_service_container" {
  type = list(number)
  description = "List of service ports to release in the load balancing security group"
}

variable "aws_vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "xx.xx.0.0/16"
}

variable "aws_subnet_private_subnet_a" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "xx.xxx.0.0/24"
}

variable "aws_subnet_private_subnet_b" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "xx.xxx.1.0/24"
}

variable "aws_subnet_public_subnet_a" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "xx.xxx.2.0/24"
}

variable "aws_subnet_public_subnet_b" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "xx.xxx.3.0/24"
}

variable "environment" {
  type = string
  description = "Application environment."
}
