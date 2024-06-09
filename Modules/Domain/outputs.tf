output "LB_DNS" {
  description = "Name of the generated DNS of the Load Balancer"
  value       = aws_lightsail_lb.lb01.dns_name
}

output "LB_NAME" {
  description = "Load Balancer that we use in the server module to attach instances to it"
  value       = aws_lightsail_lb.lb01.name
}