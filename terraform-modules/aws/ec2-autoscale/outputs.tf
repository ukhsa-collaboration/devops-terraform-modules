output "name" {
  description = "Generated name from local configuration."
  value       = module.resource_name_prefix.resource_name
}

output "launch_template_name" {
  description = "The name of the launch template."
  value       = aws_launch_template.ec2_lt.name
}

output "autoscaling_group_name" {
  description = "The name of the auto scaling group."
  value       = aws_autoscaling_group.ec2_asg.name
}

output "security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.security_group.id
}

output "security_group_name" {
  description = "The name of the security group."
  value       = aws_security_group.security_group.name
}
