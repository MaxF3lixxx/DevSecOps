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
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_web.id]

  tags = {
    Name = "gym-mobile-backend"
    Environment = "DevSecOps"
  }
}

output "instance_public_ip" {
  value = aws_instance.gym_backend.public_ip
}
