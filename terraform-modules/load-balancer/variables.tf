########################
#    Resource Naming   #
########################
variable "name" {
  description = "The name of the resources"
  type        = string
}

########################
#    Network Config     #
########################
variable "subnets" {
  description = "List of subnets"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "VPC ID for resources"
  type        = string
}

########################
# Target Group Config  #
########################
variable "target_groups" {
  description = "List of target groups configurations"
  type = list(object({
    port     = number
    protocol = string
    health_check = object({
      matcher  = string
      path     = string
      interval = number
    })
  }))
  default = []
}

########################
#   Listener Config    #
########################
variable "listeners" {
  description = "List of listener configurations"
  type = list(object({
    port        = number
    protocol    = string
    action_type = string
  }))
  default = []
}

########################
# Security Group Rules #
########################
variable "ingress_rules" {
  description = "List of ingress rules for security group"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = optional(list(string))
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules for security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

########################
#        Tags           #
########################
variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}
