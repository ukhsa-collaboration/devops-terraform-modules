module "tags" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/tags?ref=TF/helpers/tags/vALPHA_0.0.0"

  project     = var.project
  client      = var.client
  owner       = var.owner
  environment = var.environment
  additional_tags = {
    "Purpose" = "Proof of Concept"
  }
}

module "waf" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/azure/web-application-firewall?ref=TF/azure/web-application-firewall/vALPHA_0.0.0"

  name = var.name
  resource_group = "rg-apimpoc"

  tags = module.tags.tags
}