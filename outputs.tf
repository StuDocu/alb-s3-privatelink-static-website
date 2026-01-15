output "alb_dns_name" {
  description = "DNS name of the internal ALB"
  value       = aws_lb.internal.dns_name
}

output "alb_arn" {
  description = "ARN of the internal ALB"
  value       = aws_lb.internal.arn
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.website.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.website.arn
}

output "vpc_endpoint_id" {
  description = "ID of the S3 VPC Endpoint"
  value       = aws_vpc_endpoint.s3.id
}

output "vpc_endpoint_ips" {
  description = "Private IPs of the VPC Endpoint"
  value       = [for eni in data.aws_network_interface.vpce : eni.private_ip]
}

output "private_hosted_zone_id" {
  description = "ID of the Route53 Private Hosted Zone"
  value       = aws_route53_zone.private.zone_id
}

output "website_url" {
  description = "URL of the private website"
  value       = "https://${var.domain_name}/"
}
