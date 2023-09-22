##########################
#      Route Table       #
##########################
output "route_table_id" {
  description = "The ID of the route table."
  value       = aws_route_table.route_table.id
}

output "route_table_association_ids" {
  description = "The IDs of the route table associations."
  value       = aws_route_table_association.route_table_association.*.id
}
