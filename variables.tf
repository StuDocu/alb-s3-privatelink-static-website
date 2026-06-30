variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "domain_name" {
  description = "Domain name for the static website (must match ACM certificate)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs (minimum 2 in different AZs)"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the ALB"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "bucket_policy_additions" {
  description = "Policy statements to add to the bucket policy"
  type        = list(any)
  default     = []
}

variable "create_hosted_zone" {
  description = "Set to `true` to create a new hosted zone; otherwise reuse an existing one"
  type        = bool
  default     = false
}

variable "hosted_zone_name" {
  description = "Name of the hosted zone to reuse if not creating a new one. Only used if `create_hosted_zone` is set to `false`."
  type        = string
  default     = ""
}
