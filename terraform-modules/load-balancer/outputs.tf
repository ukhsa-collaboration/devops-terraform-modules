
output "name" {
  description = "Generated name from local configuration."
  value       = module.resource_name_prefix.resource_name
}

output "load_balancer_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_alb.application_load_balancer.arn
}

output "load_balancer_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_alb.application_load_balancer.dns_name
}

output "load_balancer_zone_id" {
  description = "The canonical hosted zone ID of the Application Load Balancer (to be used in Route 53 Alias records)"
  value       = aws_alb.application_load_balancer.zone_id
}

output "target_group_arns" {
  description = "The ARNs of the target groups"
  value       = aws_lb_target_group.target_group[*].arn
}

output "listener_arns" {
  description = "The ARNs of the listeners"
  value       = aws_lb_listener.listener[*].arn
}

output "security_group_id" {
  description = "The ID of the security group associated with the Load Balancer"
  value       = aws_security_group.load_balancer_security_group.id
}
