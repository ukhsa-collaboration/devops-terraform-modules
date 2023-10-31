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

module "subnets" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/aws/subnet?ref=TF/aws/subnet/vALPHA_0.0.0"

  name               = var.name
  vpc_id             = var.vpc_id
  subnet_cidr_blocks = [var.subnet_1_cidr_block, var.subnet_2_cidr_block, var.subnet_3_cidr_block]

  tags = module.tags.tags
}