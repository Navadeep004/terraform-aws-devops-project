variable "vpc_id" {
  description = "ID of the VPC where EC2 instances will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs where the EC2 instances will be deployed"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID used to launch the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "alb_security_group_id" {
  description = "Security group ID of the Application Load Balancer"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "user_data" {
  description = "User data script used to bootstrap the EC2 instances"
  type        = string
  default     = ""
}