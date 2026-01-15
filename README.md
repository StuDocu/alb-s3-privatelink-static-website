# ALB + S3 + PrivateLink Static Website (Terraform)

Terraform module to deploy a private HTTPS static website using AWS ALB, S3, and PrivateLink.

Based on the AWS Blog: [Hosting Internal HTTPS Static Websites with ALB, S3, and PrivateLink](https://aws.amazon.com/blogs/networking-and-content-delivery/hosting-internal-https-static-websites-with-alb-s3-and-privatelink/)

## Architecture
Client (Private) --> Route53 PHZ(private hosted zone) --> ALB Internal --> S3 VPC Endpoint --> S3 Bucket
.                                                                |
.                                                            ACM Certificate


## Problem Solved

When accessing S3 through VPC Endpoint (REST API), requests to `/` return XML `ListBucketResult` instead of website content.

**Solution:** ALB Listener rule redirects `*/` to `/#{path}index.html`

## Prerequisites

- AWS Account
- VPC with at least 2 private subnets
- ACM Certificate for your domain
- Private connectivity (VPN, Direct Connect, or Bastion)
- Terraform >= 1.0

## Usage

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/alb-s3-privatelink-static-website.git
cd alb-s3-privatelink-static-website
```

Create your tfvars file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit terraform.tfvars with your values:

```bash
aws_region         = "us-east-1"
domain_name        = "portal.example.com"
vpc_id             = "vpc-xxxxxxxxx"
private_subnet_ids = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]
certificate_arn    = "arn:aws:acm:us-east-1:xxxxxxxxxxxx:certificate/xxxxxxxx"
```

Deploy:

```bash
terraform init
terraform plan
terraform apply
```

Test from inside the VPC:

```bash
curl -I https://portal.example.com/
curl -sL https://portal.example.com/
```

Resources Created

```bash
Resource	                    Purpose
S3 Bucket	                    Host static files
S3 Bucket Policy	            Restrict access to VPC Endpoint
VPC Endpoint (Interface)	    Private connectivity to S3
Security Groups	                Control traffic flow
Target Group	                Register VPC Endpoint IPs
ALB (Internal)	                Terminate TLS, route traffic
ALB Listener	                HTTPS on port 443
ALB Listener Rule	            REDIRECT */ to /index.html
Route53 PHZ	                    Private DNS resolution
Route53 Record	                Alias to ALB
```

Cleanup:

```bash
terraform destroy
```


## Important note
Take in count that this architecture is designed for internal routing
There won't be access from external resources, it is all within the private VPC
