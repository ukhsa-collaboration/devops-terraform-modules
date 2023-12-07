module "tags" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/tags?ref=TF/helpers/tags/vALPHA_0.0.1"

  project     = var.project
  client      = var.client
  owner       = var.owner
  environment = var.environment
  additional_tags = {
    "Purpose" = "Proof of Concept"
  }
}

module "api" {
    source = "../../../terraform-modules/azure/api-gateway"

    name = var.name
    resource_group =  var.resource_group
    
    publisher_email = var.publisher_email
    publisher_name = var.publisher_name

    sku = var.sku
    sku_count = var.sku_count

    tags = module.tags.tags
}

