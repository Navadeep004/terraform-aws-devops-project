output "instance_ids" {
  description = "IDs of the application EC2 instances"
  value       = aws_instance.app[*].id
}

output "private_ips" {
  description = "Private IP addresses of the application EC2 instances"
  value       = aws_instance.app[*].private_ip
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.ec2.id
}