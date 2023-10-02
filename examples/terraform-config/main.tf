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

module "subnets" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/subnet?ref=subnet/vALPHA_0.0.0"

  name               = var.name
  vpc_id             = var.vpc_id
  subnet_cidr_blocks = [var.subnet_1_cidr_block, var.subnet_2_cidr_block, var.subnet_3_cidr_block]

  tags = module.tags.tags
}


module "ec2_instance" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/ec2-autoscale?ref=ec2-autoscale/vALPHA_0.0.0"

  name                 = var.name
  ami                  = var.ec2_ami
  instance_type        = var.ec2_type
  vpc_id               = var.vpc_id
  vpc_zone_identifiers = module.subnets.subnet_ids
  target_group_arns    = module.load_balancer.target_group_arns

  # For testing
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y netcat-traditional
    while true; do 
      echo -e "HTTP/1.1 200 OK\n\n<h1>Hello, World from EC2 User Data!</h1>" | nc -l -p 8501 -q 1;
    done & 
  EOF

  ingress_rules = [
    {
      from_port   = 8501
      to_port     = 8501
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = module.tags.tags
}

module "load_balancer" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/load-balancer?ref=load-balancer/vALPHA_0.0.0"

  name   = var.name

  certificate_arn = module.domain_routing.acm_certificate_arn

  subnets = module.subnets.subnet_ids
  vpc_id  = var.vpc_id
  target_groups = [
    {
      port     = 8501
      protocol = "HTTP"
      health_check = {
        matcher  = "200,301,302,307"
        path     = "/"
        interval = 70
      }
    }
  ]

  listeners = [
    {
      port     = 80
      protocol = "HTTP"
      actions = [
        {
          type              = "redirect"
          redirect_port     = "443"
          redirect_protocol = "HTTPS"
          status_code       = "HTTP_301"
        }
      ]
    },
    {
      port     = 443
      protocol = "HTTPS"
      actions = [
        {
          type             = "forward"
          target_group_arn = module.load_balancer.target_group_arns[0] # Use the first target group for HTTPS
        }
      ]
    }
  ]

  listener_rules = [
    {
      listener_port = 443
      priority      = 1
      protocol      = "HTTPS"
      actions = [
        {
          type = "authenticate-cognito"
          authenticate_cognito = {
            user_pool_arn       = module.cognito.cognito_user_pool_arn
            user_pool_client_id = module.cognito.cognito_user_pool_client_id
            user_pool_domain    = module.cognito.cognito_domain
          }
        },
        {
          type             = "forward"
          target_group_arn = module.load_balancer.target_group_arns[0] # Use the first target group for HTTPS
        }
      ]
      conditions = [
        {
          field  = "path-pattern"
          values = ["/"]
        }
      ]
    }
  ]

  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      # security_groups = [var.default_sg]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      # security_groups = [var.default_sg]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = module.tags.tags
}
module "domain_routing" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/domain-routing?ref=domain-routing/vALPHA_0.0.0"

  name   = var.name
  vpc_id = var.vpc_id

  # Route table configuration
  subnet_ids            = module.subnets.subnet_ids
  associate_route_table = true
  routes = [
    {
      cidr_block = "0.0.0.0/0",
      gateway_id = "igw-0dbe98ec578dae53e"
    }
  ]

  # Route 53 configuration
  primary_domain         = var.primary_domain
  subdomain_prefix       = var.subdomain_prefix
  load_balancer_dns_name = module.load_balancer.load_balancer_dns_name
  load_balancer_zone_id  = module.load_balancer.load_balancer_zone_id

  tags = module.tags.tags
}

module "cognito" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/cognito?ref=cognito/vALPHA_0.0.0"

  name                        = var.name
  lambda_auth_challenge_arn   = var.lambda_cognito_pre_signup_arn
  password_min_length         = 12
  temp_password_validity_days = 7
  token_validity              = 1
  callback_url                = var.cognito_callback_url
  domain                      = var.subdomain_prefix

  schema = [
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "email"
      required                 = true
    }
  ]

  recovery_mechanism = [
    {
      name     = "verified_email"
      priority = 1
    }
  ]

  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]

  allowed_oauth_scopes = [
    "email",
    "openid"
  ]

  supported_identity_providers = ["COGNITO"]

  allowed_oauth_flows = ["code"]

  tags = module.tags.tags
}

