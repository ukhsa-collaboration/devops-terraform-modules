########################
#    Resource Naming   #
########################
variable "name" {
  description = "The name of the resources"
  type        = string
}

########################
#    Network Config    #
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
#      Listener        #
########################
variable "listeners" {
  description = "The list of listeners for the load balancer"
  type = list(object({
    port     = number
    protocol = string
    actions = list(object({
      type              = string
      target_group_arn  = optional(string)
      redirect_port     = optional(string)
      redirect_protocol = optional(string)
      status_code       = optional(string)
    }))
  }))
  default = []
}

########################
#     Listener Rules   #
########################
variable "listener_rules" {
  description = "The list of listener rules for the load balancer"
  type = list(object({
    listener_port = number
    protocol      = string
    priority      = number
    actions = list(object({
      type             = string
      target_group_arn = optional(string)
      authenticate_cognito = optional(object({
        user_pool_arn       = string
        user_pool_client_id = string
        user_pool_domain    = string
      }))
    }))
    conditions = list(object({
      field  = string
      values = list(string)
    }))
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
#     Certifacte       #
########################
variable "certificate_arn" {
  description = " SSL/TLS certificate arn"
  type        = string
  default     = null
}

########################
#        Tags           #
########################
variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}
