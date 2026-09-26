# Terraform AWS DevOps Project

A production-style AWS infrastructure project built using **Terraform** and automated through **Jenkins CI/CD**.

The project provisions a complete AWS environment consisting of a VPC, public and private subnets, NAT Gateway, Application Load Balancer, and private EC2 application servers. Terraform state is stored remotely in Amazon S3 with state locking enabled.

## Project Overview

This project demonstrates how to:

- Provision AWS infrastructure using Terraform
- Organize Terraform code using reusable modules
- Deploy EC2 instances in private subnets
- Expose applications through an Application Load Balancer
- Provide outbound internet access to private EC2 instances using a NAT Gateway
- Store Terraform state remotely in Amazon S3
- Use Terraform state locking with S3 lockfiles
- Automate Terraform workflows using Jenkins
- Require manual approval before infrastructure deployment

## Technologies Used

- **AWS**
  - VPC
  - EC2
  - Application Load Balancer (ALB)
  - Target Groups
  - NAT Gateway
  - Internet Gateway
  - Security Groups
  - S3
- **Terraform**
- **Jenkins**
- **Git & GitHub**
- **Linux / Bash**

## Architecture


                         Internet
                            │
                            ▼
                    ┌──────────────┐
                    │     ALB      │
                    │ Public Subnets│
                    └───────┬──────┘
                            │
                      Target Group
                       Port 8080
                       /        \
                      ▼          ▼
               ┌──────────┐  ┌──────────┐
               │  EC2-1   │  │  EC2-2   │
               │ Private  │  │ Private  │
               │   AZ-1   │  │   AZ-2   │
               └────┬─────┘  └────┬─────┘
                    │              │
                    └──────┬───────┘
                           │
                    Private Route Tables
                           │
                           ▼
                    ┌──────────────┐
                    │ NAT Gateway  │
                    │ Public Subnet│
                    └──────┬───────┘
                           │
                           ▼
                    Internet Gateway
                           │
                           ▼
                        Internet

## Project Structure

terraform-aws-devops-project/
│
├── README.md
├── .gitignore
├── Jenkinsfile
│
└── terraform/
    │
    ├── backend.tf
    ├── versions.tf
    ├── providers.tf
    ├── variables.tf
    ├── main.tf
    ├── outputs.tf
    ├── .terraform.lock.hcl
    │
    ├── app/
    │   └── user_data.sh
    │
    └── modules/
        │
        ├── VPC/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        │
        ├── EC2/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        │
        └── ALB/
            ├── main.tf
            ├── variables.tf
            └── outputs.tf