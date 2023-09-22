
output "name" {
  description = "Generated name from local configuration."
  value       = module.resource_name_prefix.resource_name
}

output "subnet_ids" {
  description = "List of Subnet IDs"
  value       = aws_subnet.subnet.*.id
}

output "subnet_arns" {
  description = "List of Subnet ARNs"
  value       = aws_subnet.subnet.*.arn
}

output "availability_zones" {
  description = "List of available Availability Zones"
  value       = data.aws_availability_zones.available.names
}
