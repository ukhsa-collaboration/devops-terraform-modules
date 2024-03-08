######################################
#     Naming and tagging Config      #
######################################
module "tags" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/tags?ref=e33b08113eef62432e32fd837d0e75f871b38340"

  project         = var.tags.project
  client          = var.tags.client
  owner           = var.tags.owner
  environment     = var.tags.environment
  additional_tags = var.tags.additional_tags != null ? var.tags.additional_tags : {}
}

module "resource_name_prefix" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/resource-name-prefix?ref=e33b08113eef62432e32fd837d0e75f871b38340"

  name = module.tags.tags["Project"]
  tags = module.tags.tags
}

######################################
#              Webapp                #
######################################
resource "azurerm_windows_web_app" "web_app" {
  #checkov:skip=CKV_AZURE_88:Ensure that app services use Azure Files
  name = "${module.resource_name_prefix.resource_name}-${var.webapp_config.web_app_name}"

  resource_group_name           = var.resource_group_name
  location                      = var.location
  service_plan_id               = var.service_plan_id
  virtual_network_subnet_id     = var.webapp_config.virtual_network_subnet_id
  client_affinity_enabled       = var.webapp_config.enable_client_affinity
  https_only                    = var.webapp_config.enable_https
  client_certificate_enabled    = var.webapp_config.client_certificate_enabled
  public_network_access_enabled = var.webapp_config.public_network_access_enabled

  tags = {
    environment = module.tags.tags
  }

  identity {
    type = "SystemAssigned"
  }

  logs {
    detailed_error_messages = var.webapp_config.detailed_error_messages
    failed_request_tracing  = var.webapp_config.failed_request_tracing

    http_logs {
      file_system {
        retention_in_days = var.webapp_config.retention_in_days
        retention_in_mb   = var.webapp_config.retention_in_mb
      }
    }
  }

  site_config {
    always_on         = var.webapp_config.always_on
    http2_enabled     = var.webapp_config.http2_enabled
    health_check_path = var.webapp_config.health_check_path
    ftps_state        = var.webapp_config.ftps_state #"FtpsOnly"

    dynamic "ip_restriction" {
      for_each = var.webapp_config.restriction_action != null ? [1] : []

      content {
        action      = var.webapp_config.restriction_action
        name        = var.webapp_config.restriction_name
        priority    = var.webapp_config.restriction_priority
        service_tag = var.webapp_config.restriction_service_tag
      }

    }
  }

  dynamic "auth_settings" {
    for_each = var.webapp_config.auth_settings_enabled != null ? [1] : []

    content {
      enabled = var.webapp_config.auth_settings_enabled
    }
  }
}

######################################
#              Connetion             #
######################################
resource "azurerm_app_service_connection" "connection" {
  count              = var.webapp_connection_config.service_connection_name == null ? 0 : 1
  name               = "${module.resource_name_prefix.resource_name}-${var.webapp_connection_config.service_connection_name}"
  app_service_id     = azurerm_windows_web_app.web_app.id
  target_resource_id = var.connection_target_resource
  authentication {
    type = var.webapp_connection_config.connection_authentication_type
  }
}



