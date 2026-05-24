variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "gym-app"
}
