output "https_endpoint" {
  description = " HTTPS endpoint"
  value       = var.public_hostname
}

output "alb_dns" {
  description = "ALB DNS name "
  value       = aws_lb.this.dns_name
}

output "db_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.postgres.endpoint
}

