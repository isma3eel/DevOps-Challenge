output "EIP" {
  description = "EIP to access the Instance: "
  value       = aws_lightsail_static_ip.static_ip.ip_address
}

output "Instance_ID" {
  description = "Instance_ID"
  value       = aws_lightsail_instance.lightsail_instance.name
}