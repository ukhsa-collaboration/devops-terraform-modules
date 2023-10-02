##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/tags?ref=resource-name-prefix/vALPHA_0.0.0"

  name = var.name
  tags = var.tags
}

##########################
#   Launch Template      #
##########################
resource "aws_launch_template" "ec2_lt" {
  name_prefix   = "${module.resource_name_prefix.resource_name}-lt"
  image_id      = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.security_group.id]

  user_data = base64encode(var.user_data)

  tag_specifications {
    resource_type = "network-interface"
    tags          = merge(var.tags, { "Name" = "${module.resource_name_prefix.resource_name}-ec2-ni" })
  }

  lifecycle {
    create_before_destroy = true
  }
}

##########################
#   Auto Scaling Group   #
##########################
resource "aws_autoscaling_group" "ec2_asg" {
  name_prefix = "${module.resource_name_prefix.resource_name}-asg"

  launch_template {
    id      = aws_launch_template.ec2_lt.id
    version = "$Latest"
  }

  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.vpc_zone_identifiers
  target_group_arns   = var.target_group_arns

  tag {
    key                 = "Name"
    value               = "${module.resource_name_prefix.resource_name}-ec2"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

##########################
#     Security Group     #
##########################
resource "aws_security_group" "security_group" {
  name   = "${module.resource_name_prefix.resource_name}-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = var.tags
}