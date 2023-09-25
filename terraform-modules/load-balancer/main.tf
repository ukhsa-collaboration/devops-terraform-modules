##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "../resource-name-prefix"

  name                 = var.name
  tags = var.tags
}

##########################
#      Load Balancer     #
##########################
resource "aws_alb" "application_load_balancer" {
  name               = "${module.resource_name_prefix.resource_name}-lb"
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = [aws_security_group.load_balancer_security_group.id]
  tags               = var.tags
}

resource "aws_lb_target_group" "target_group" {
  count = length(var.target_groups)

  name        = "${module.resource_name_prefix.resource_name}-${count.index}-tg"
  port        = var.target_groups[count.index].port
  protocol    = var.target_groups[count.index].protocol
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    matcher  = var.target_groups[count.index].health_check.matcher
    path     = var.target_groups[count.index].health_check.path
    interval = var.target_groups[count.index].health_check.interval
  }

  tags = merge(var.tags, { "Name" = "${module.resource_name_prefix.resource_name}-${count.index + 1}-lb-target-group" })
}

resource "aws_lb_listener" "listener" {
  for_each          = { for i in var.listeners : "${i.port}-${i.protocol}" => i }
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = each.value.port
  protocol          = each.value.protocol
  certificate_arn   = each.value.protocol == "HTTPS" ? var.certificate_arn : null

  dynamic "default_action" {
    for_each = each.value.actions
    content {
      type = default_action.value["type"]

      dynamic "redirect" {
        for_each = default_action.value["type"] == "redirect" ? [default_action.value] : []
        content {
          port        = redirect.value["redirect_port"]
          protocol    = redirect.value["redirect_protocol"]
          status_code = redirect.value["status_code"]
        }
      }

      target_group_arn = lookup(default_action.value, "target_group_arn", null)
    }
  }

  tags = merge(var.tags, { "Name" = "${module.resource_name_prefix.resource_name}-${each.key}-lb-listener" })
}

##########################
#     Security Group     #
##########################
resource "aws_security_group" "load_balancer_security_group" {
  name   = "${module.resource_name_prefix.resource_name}-lb-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port       = ingress.value["from_port"]
      to_port         = ingress.value["to_port"]
      protocol        = ingress.value["protocol"]
      cidr_blocks     = ingress.value["cidr_blocks"]
      security_groups = lookup(ingress.value, "security_groups", null)
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }
  tags = var.tags
}
