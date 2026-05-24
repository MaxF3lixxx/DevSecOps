terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Obtener la AMI más reciente de Amazon Linux 2023 (recomendado)
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "gym-app-vpc"
  }
}

# Security Group
resource "aws_security_group" "allow_web" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gym-app-sg"
  }
}

# EC2 Instance (Backend)
resource "aws_instance" "gym_backend" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_web.id]

  tags = {
    Name        = "gym-mobile-backend"
    Environment = "DevSecOps"
    Project     = "GymApp"
  }
}

output "instance_public_ip" {
  value = aws_instance.gym_backend.public_ip
}

output "instance_id" {
  value = aws_instance.gym_backend.id
}
