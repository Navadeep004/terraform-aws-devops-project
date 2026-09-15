output "aws_account_id" {
  description = "AWS account ID used by Terraform"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  description = "AWS region used by Terraform"
  value       = data.aws_region.current.region
}

output "vpc_id" {
  description = "ID of the terraform-managed VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "ec2_instance_ids" {
  description = "IDs of the application EC2 instances"
  value       = module.ec2.instance_ids
}

output "ec2_private_ips" {
  description = "Private IP addresses of the application EC2 instances"
  value       = module.ec2.private_ips
}