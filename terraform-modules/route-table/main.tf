##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "../resource_name_prefix"

  name                 = var.name
  tags = var.tags
}

##########################
#       Route Table      #
##########################
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block = route.value.cidr_block
      gateway_id = lookup(route.value, "gateway_id", null)
      nat_gateway_id = lookup(route.value, "nat_gateway_id", null)
    }
  }

  tags = merge(var.tags, { "Name" = "${module.resource_name_prefix.resource_name}-rt" })
}

###########################
# Route Table Association #
###########################
resource "aws_route_table_association" "route_table_association" {
  count          = var.associate_route_table ? length(var.subnet_ids) : 0
  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.route_table.id
}

