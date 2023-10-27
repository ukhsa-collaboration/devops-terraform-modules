########################
#    Resource Naming   #
########################
variable "name" {
  description = "The name of the resources"
  type        = string
}

########################
#       VPC & Subnet   #
########################
variable "vpc_id" {
  description = "The VPC ID where subnets will be created."
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "List of CIDR blocks for subnets. The number of blocks should match or exceed the number of available AZs."
  type        = list(string)
}

########################
#         Tags         #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}