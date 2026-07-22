# AWS Terraform Training

This repository is a simple Terraform training project that deploys two EC2 instances in AWS: one running Ubuntu 24.04 LTS and one running Amazon Linux 2023.

The project creates:

- A VPC with a public subnet
- An internet gateway and public route table
- A security group that permits SSH from approved CIDR networks
- Ubuntu and Amazon Linux EC2 instances
- SSH access using an AWS EC2 key pair and an additional authorized public key
- An S3 backend for remote Terraform state and state locking

## Basic usage

Make sure your AWS credentials are configured and the S3 backend bucket already exists, then run:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

To remove the resources when training is complete:

```bash
terraform destroy
```

Review the Terraform plan before applying or destroying resources. AWS resources created by this project may incur charges while they are running.
