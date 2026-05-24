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

resource "aws_s3_bucket" "gym_app_assets" {
  bucket = "gym-app-assets-maxfelix-2026"
}

resource "aws_instance" "gym_backend" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name        = "GymApp-Backend"
    Environment = "Production"
    Project     = "DevSecOps"
  }
}
