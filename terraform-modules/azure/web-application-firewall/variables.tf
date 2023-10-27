########################
#    Resource Naming   #
########################
variable "name" {
  description = "The base name of the resources"
  type        = string
}

##########################
#    Resource Group      #
##########################
variable "resource_group" {
  description = "The base name of the resources"
  type        = string
}

############################
# Web Application Firewall #
############################


########################
#      Tags Config     #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}