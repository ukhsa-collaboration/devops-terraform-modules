########################
#    Resource Naming   #
########################
variable "name" {
  description = "The base name of the resources"
  type        = string
}

########################
#       VPC Config     #
########################
variable "vpc_id" {
  description = "The VPC ID where the route table will be created."
  type        = string
}

########################
#       Route 53       #
########################
variable "load_balancer_dns_name" {
  description = "DNS name of the load balancer."
  type        = string
}

variable "load_balancer_zone_id" {
  description = "Zone ID of the load balancer."
  type        = string
}

########################
#     Routes Config    #
########################
variable "routes" {
  description = "List of maps containing routes configurations."
  type = list(object({
    cidr_block     = string
    gateway_id     = optional(string)
    nat_gateway_id = optional(string)
  }))
  default = []
}


variable "associate_route_table" {
  description = "Whether to associate the subnets with the provided route table."
  type        = bool
  default     = false
}

########################
#  Subnets Association #
########################
variable "subnet_ids" {
  description = "List of subnet IDs to associate with."
  type        = list(string)
  default     = []
}

########################
# ACM Certificate Vars #
########################
variable "primary_domain" {
  description = "The primary domain name."
  type        = string
}

variable "subdomain_prefix" {
  description = "The subdomain name."
  type        = string
}

########################
#      Tags Config     #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}
