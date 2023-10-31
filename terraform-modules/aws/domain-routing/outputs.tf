##########################
#      ACM Certificate   #
##########################
output "acm_certificate_arn" {
  description = "The ARN of the created ACM certificate."
  value       = aws_acm_certificate.cert.arn
}

output "acm_certificate_validation_arn" {
  description = "The ARN of the ACM certificate validation."
  value       = aws_acm_certificate_validation.cert_validation.certificate_arn
}

##########################
#        Route 53        #
##########################
output "route53_zone_id" {
  description = "The ID of the selected Route 53 zone."
  value       = data.aws_route53_zone.selected.zone_id
}

output "frontend_record_name" {
  description = "The fully qualified domain name of the frontend record in Route 53."
  value       = aws_route53_record.frontend_record.name
}

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

##########################
#     General Tags       #
##########################
output "resource_name_prefix_output" {
  description = "The generated resource name prefix."
  value       = module.resource_name_prefix.resource_name
}
