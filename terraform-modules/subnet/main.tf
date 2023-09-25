##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "../resource-name-prefix"

  name                 = var.name
  tags = var.tags
}

###########################
# Availability Zones Info #
###########################
data "aws_availability_zones" "available" {
  state = "available"
}

##########################
#         Subnet         #
##########################
resource "aws_subnet" "subnet" {
  count             = min(length(data.aws_availability_zones.available.names), length(var.subnet_cidr_blocks))
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = merge(var.tags, { "Name" = "${module.resource_name_prefix.resource_name}-${count.index + 1}-subnet" })
}
