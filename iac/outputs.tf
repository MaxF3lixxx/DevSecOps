output "instance_public_ip" {
  description = "IP pública de la instancia backend"
  value       = aws_instance.gym_backend.public_ip
}

output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.gym_backend.id
}

output "security_group_id" {
  description = "ID del Security Group"
  value       = aws_security_group.allow_web.id
}
