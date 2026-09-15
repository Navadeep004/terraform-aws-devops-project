variable "vpc_id" {
  description = "ID of the VPC where the ALB will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs where the ALB will be deployed"
  type        = list(string)
}

variable "target_instance_ids" {
  description = "EC2 instance IDs registered with the ALB target group"
  type        = list(string)
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}