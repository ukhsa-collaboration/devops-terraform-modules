##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "../resource-name-prefix"

  name = var.name
  tags = var.tags
}

##########################
#      Route 53          #
##########################
data "aws_route53_zone" "selected" {
  name = var.primary_domain
}

resource "aws_route53_record" "frontend_record" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.subdomain_prefix}.${var.primary_domain}"
  type    = "A"

  alias {
    name                   = var.load_balancer_dns_name
    zone_id                = var.load_balancer_zone_id
    evaluate_target_health = true
  }
}

##########################
#       Route Table      #
##########################
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block     = route.value.cidr_block
      gateway_id     = lookup(route.value, "gateway_id", null)
      nat_gateway_id = lookup(route.value, "nat_gateway_id", null)
    }
  }

  tags = merge(var.tags, { "Name" = "${module.resource_name_prefix.resource_name}-rt" })
}

###########################
# Route Table Association #
###########################
resource "aws_route_table_association" "route_table_association" {
  count          = var.associate_route_table ? length(var.subnet_ids) : 0
  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.route_table.id
}

##########################
#    ACM Certificate     #
##########################
resource "aws_acm_certificate" "cert" {
  domain_name       = "${var.subdomain_prefix}.${var.primary_domain}"
  validation_method = "DNS"

  tags = merge(var.tags, { "Name" = "${module.resource_name_prefix.resource_name}-certificate" })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  name    = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  zone_id = data.aws_route53_zone.selected.zone_id
  records = [tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}



