data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = "10.0.0.0/16"

  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)

  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]

  environment = var.environment
}

module "alb" {
  source = "./modules/alb"

  vpc_id = module.vpc.vpc_id

  public_subnet_ids = module.vpc.public_subnet_ids

  target_instance_ids = module.ec2.instance_ids

  environment = var.environment
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnet_ids

  ami_id = data.aws_ami.ubuntu.id

  instance_type = "t3.micro"

  alb_security_group_id = module.alb.security_group_id

  environment = var.environment

  user_data = file("${path.module}/app/user_data.sh")
}