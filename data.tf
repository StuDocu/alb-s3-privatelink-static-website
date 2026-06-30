data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_route53_zone" "private" {
  count        = var.create_hosted_zone ? 0 : 1
  name         = var.hosted_zone_name
  private_zone = true
}
