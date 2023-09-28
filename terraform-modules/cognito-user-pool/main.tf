##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "../resource-name-prefix"

  name                 = var.name
  tags = var.tags
}

##########################
#   Cognito User Pool    #
##########################
resource "aws_cognito_user_pool" "cognito_user_pool" {
  name = "${module.resource_name_prefix.resource_name}-cognito-up"
  username_attributes = ["email"]
  auto_verified_attributes = ["email"]

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true
  }

  lambda_config {
    create_auth_challenge = "arn:aws:lambda:eu-west-2:975276445027:function:streamlit-poc-cognito-pre-signup"
  } 

  password_policy {
    minimum_length = 12
    require_lowercase = true
    require_uppercase = true
    require_symbols = true
    require_numbers = true
    temporary_password_validity_days = 7
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
}

##########################
#     Cognito Client     #
##########################
resource "aws_cognito_user_pool_client" "client" {
  name = "${module.resource_name_prefix.resource_name}-cognito-client"

  user_pool_id = aws_cognito_user_pool.cognito_user_pool.id

  generate_secret = true
  supported_identity_providers = ["COGNITO"]
  refresh_token_validity          = 1
  access_token_validity           = 1
  id_token_validity               = 1

  prevent_user_existence_errors   = "ENABLED"
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]
  callback_urls = [ "https://iac-streamlit-poc.qap-ukhsa.uk/oauth2/idpresponse"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = [
    "email",
    "openid"
  ]
  allowed_oauth_flows = [
    "code"
  ]
}