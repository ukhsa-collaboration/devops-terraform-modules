# Others
variable "additional_tags" {
  description = "(Optional) Any additional tags you want to add to AWS resources"
  type        = map(string)
  default     = {}
}
