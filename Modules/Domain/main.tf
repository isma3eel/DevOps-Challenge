# Create a public DNS Zone for the domain
resource "aws_lightsail_domain" "mydomain" {
  domain_name = var.domain_name
}


# Create the Load Balancer
resource "aws_lightsail_lb" "lb01" {
  name              = "Env-LoadBalancer"
  health_check_path = "/"
  instance_port     = "80"
}


# Create the certitifcate for the Load Balancer 
resource "aws_lightsail_lb_certificate" "lbcert" {
  name        = "LoadBalancer-Certificate"
  lb_name     = aws_lightsail_lb.lb01.name
  domain_name = var.domain_name
  depends_on  = [aws_lightsail_lb.lb01]
}


## Attach the Certificate to LB (it can take up to 20 minutes to validate the ceritiface so it's better to attach manually to the LB)
# resource "aws_lightsail_lb_certificate_attachment" "test" {
#   lb_name          = aws_lightsail_lb.lb01.name
#   certificate_name = aws_lightsail_lb_certificate.lbcert.name
#   depends_on = [aws_lightsail_lb_certificate.lbcert]
# }