# Overview

This project is based on Amazon's Threat Composer Tool, an open-source solution designed to facilitate threat modeling and improve security assessment.

It has been extended to demonstrate a production-grade deployment on AWS using **Docker**, **Terraform**, **ECS**, and **GitHub Actions**, complete with automated infrastructure provisioning, CI/CD pipeline, and HTTPS-enabled access via a Load Balancer.


## Table of Contents

- [Directory Structure](#directory-structure)  
- [Features](#features)  
- [Architecture](#architecture)  
- [How to Run](#how-to-run)  
- [Live Site & Screenshots Showcase](#live-site--screenshots-showcase)    

## Directory Structure
```css
/
├── .github/
│   └── workflows/
│       ├── build-image.yml
│       ├── terraform-apply.yml
│       ├── terraform-destroy.yml
│       └── terraform-plan.yml
├── app/
├── src/
├── terraform/
│   ├── .terraform/
│   ├── modules/
│   │   ├── alb/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── ecr/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── ecs/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── security_groups/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── vpc/
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── .terraform.lock.hcl
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── terraform.tfvars
│   └── variables.tf
├── .gitignore
├── Dockerfile
└── README.md
```


## Features
- Based on Amazon's Threat Model
- Dockerized, lightweight, multi-stage build
- Modular Terraform structure
- ECS Deployement on private subnets
- Public-facing HTTPS via Application load balancer and Amazon Certificate Manager
- Security scanning using Trivy in Docker image build pipeline
- CI/CD separation: individual workflows for plan, apply, and destroy
- DNS Configuration for custom domain access


## Architecture

![alt text](/src/ECS-Architecture.JPG)

## How to Run

Follow these steps to deploy this project to your own custom domain using AWS. This guide assumes you are using a domain like `tm.yourdomain.com`, similar to the example `tm.saidcraft.com`.

### 1. Clone the Repository
```bash 
git clone git@github.com:SaidCraft/ECS-Threat-Modelling-Tool-Project.git
cd ECS-Threat-Modelling-Tool-Project
```

### 2. Configure AWS Credentials
Set up access to your AWS account:
```bash
aws configure
```
You will be prompted to enter:
- **AWS Access Key ID**
- **AWS Secret Access Key**
- **Default region** (e.g., eu-west-2)

Verify access:
```bash
aws sts get-caller-identity
```

### 3. Request an SSL Certificate (ACM)
1. Go to **AWS Certificate Manager** (ACM)
2. Request a **public certificate** for your domain (e.g., tm.yourdomain.com)
3. Provide one domain for your certificate
4. Choose **DNS validation** and leave the remaining settings as default.
5. ACM provides you a **CNAME record** - add it in your domain DNS
6. Wait until the status shows **Issued**
7. Copy the **Certificate** ARN - This will be used in Terraform

### 4. Edit Your Deployment (Terraform Input Setup)
Create and update the terraform.tfvars file with your own values:
```hcl
# Networking
vpc_cidr = "10.0.0.0/16"
vpc_name = "ECS-VPC"

public_subnet_cidrs = [
  "10.0.0.0/24",
  "10.0.1.0/24"
]

private_subnet_cidrs = [
  "10.0.10.0/24",
  "10.0.11.0/24"
]

azs = [
  "eu-west-2a",
  "eu-west-2b"
]

# ALB & HTTPS
alb_name         = "ALB-LB"
alb_sg_name      = "ALB SG"
ingress_cidr     = "0.0.0.0/0"
ingress_port     = 443
tg_name          = "IP-ECS-TG"
tg_port          = 3000
listener_port    = 443
certificate_arn  = "arn:aws:acm:eu-west-2:123456789012:certificate/your-cert-id" # <- Replace with your own ACM cert ARN

# ECS & Application
ecs_name            = "ECS-Clusters"
ecs_family          = "APP-ECS-Family"
ecs_cpu             = 1024
ecs_memory          = 3072
ecs_sg_name         = "ECS SG"
ecs_ingress_port    = 3000
service_name        = "app"
ecs_desired_count   = 2

# IAM Execution Role
execution_role_arn  = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole" # <- Replace with your own role ARN

# Docker Image
container_image     = "123456789012.dkr.ecr.eu-west-2.amazonaws.com/my-app-ecr:latest" # <- Replace with your own account ID
container_port      = 3000
```
### 5. Deploy Infrastructure with Terraform
```hcl
terraform init
terraform plan
terraform apply
```
Terraform will provision all infrastructure and output the ALB DNS.

**Note:** Your ECS tasks will initially fail because no Docker image exists in the ECR yet. Assuming your **terraform.tfvars** file is correctly configured, this will be automatically resolved once you push this project to your GitHub repository and the CI/CD pipeline runs — building and pushing the image to ECR.

### 6. Update DNS to point to the Load Balancer
Create a CNAME record on your domain provider that points to the Application Load Balancer DNS output from Terraform. 

After a few minutes, your site will be live at:
```https://tm.yourdomain.com```

### 7. Deploy CI/CD Pipeline
Push this project to your GitHub repository. Once the Terraform Apply pipeline completes successfully, the image build pipeline will trigger — building the Docker image, scanning it with Trivy, pushing it to Amazon ECR, and making the new image available to ECS for deployment.

## Live Site & Screenshots Showcase

### Live Page (HTTPS)
![alt text](/src/Website.gif)

### Browser SSL 
![alt text](/src/SSL%20Lock%20Icon.JPG)
![alt text](/src/SSL%20Certificate.JPG)

### Github Actions - Docker Image Successful Run
![alt text](/src/GitHub%20Actions%20-%20Success.JPG)

### Github Actions - Terraform Plan Successful Run
![alt text](/src/tf-plan.png)

### Github Actions - Terraform Apply Successful Run
![alt text](/src/tf-apply.png)

### Github Actions - Terraform Destroy Successful Run
![alt text](/src/tf-destroy.png)

### ECS Tasks Running
![alt text](/src/ECS-Tasks-Running.JPG)

### ALB Target Group - Healthy
![alt](/src/ALB-Target%20Group%20-%20Healthy.JPG)

