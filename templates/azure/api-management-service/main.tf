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
  source = "../../../terraform-modules/azure/api-management-service"

  name           = var.name
  resource_group = var.resource_group

  publisher_email = var.publisher_email
  publisher_name  = var.publisher_name

  sku       = var.sku
  sku_count = var.sku_count

  // API Config
  api_revision              = "1"
  api_path                  = "myapi" 
  api_protocols             = ["https"]

  # API Definition
  api_import_content_format = "swagger-link-json" 
  api_import_content_value  = "https://example.com/api/swagger.json"

  # APP Insights
  app_insights_type         = "web" // Replace with your Application Insights type

  tags = module.tags.tags

}


