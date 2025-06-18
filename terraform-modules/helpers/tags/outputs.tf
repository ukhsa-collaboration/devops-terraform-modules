output "all" {
  description = "A map of all tags to be applied to the resource including mandatory tags"
  value       = local.all_tags
}

output "mandatory" {
  description = "A map of only mandatory tags to be applied to the resource"
  value       = local.mandatory_tags
}
