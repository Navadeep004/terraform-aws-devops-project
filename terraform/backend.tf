terraform {
  backend "s3" {
    bucket       = "aws-terraform-state-004"
    key          = "terraform-aws-devops-project/terraform.state"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}