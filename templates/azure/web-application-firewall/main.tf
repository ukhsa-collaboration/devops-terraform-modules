module "tags" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/tags?ref=tags/vALPHA_0.0.0"

  project     = var.project
  client      = var.client
  owner       = var.owner
  environment = var.environment
  additional_tags = {
    "Purpose" = "Proof of Concept"
  }
}

module "waf" {
  source = "../../../terraform-modules/azure/web-application-firewall"

  name = var.name
  # waf_description = "API Gateway WAF"

  

  tags = module.tags.tags
}