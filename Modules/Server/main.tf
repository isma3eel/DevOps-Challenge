# Create an AWS Lightsail Instance.
resource "aws_lightsail_instance" "lightsail_instance" {
  name              = "${var.project_name}_Instance"
  availability_zone = "${var.aws_region}a"
  blueprint_id      = var.lightsail_blueprint
  bundle_id         = var.bundle_id
  user_data         = "sudo yum install -y docker && sudo systemctl start docker.service && sudo systemctl enable docker.service && sudo docker pull hashicorp/http-echo && sudo docker run -p 80:5678 hashicorp/http-echo -text='${data.aws_secretsmanager_secret_version.current.secret_string}'"
}


# Create a static public IP address(EIP)
resource "aws_lightsail_static_ip" "static_ip" {
  name = "${var.project_name}_static_ip"
}


# Attach static IP address to Lightsail instance
resource "aws_lightsail_static_ip_attachment" "static_ip_attach" {
  static_ip_name = aws_lightsail_static_ip.static_ip.id
  instance_name  = aws_lightsail_instance.lightsail_instance.id
}


# Allow SSH, HTTP, HTTPS for the docker container
resource "aws_lightsail_instance_public_ports" "lightsail_instance_ports" {
  instance_name = aws_lightsail_instance.lightsail_instance.id

  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }

  port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }

  port_info {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
  }
}



## Adding the Secret file content to AWS Secrets Manager

# Read the plain text file
data "local_file" "secret_file" {
  filename = "${path.module}/../../Environment/${var.project_name}/App/${var.secretFile}"
}


# Create the secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "vault" {
  name = "${var.project_name}__secret5"
}

# Update the secret manager with the content of secret File
resource "aws_secretsmanager_secret_version" "update" {
  secret_id     = aws_secretsmanager_secret.vault.id
  secret_string = data.local_file.secret_file.content
}


# Fetch the secret from AWS Secrets Manager to use it on container deployment 
data "aws_secretsmanager_secret_version" "current" {
  secret_id  = aws_secretsmanager_secret.vault.id
  depends_on = [aws_secretsmanager_secret_version.update]
}

# Add the DNS A records Entries for the generated machine inside the domain zone

resource "aws_lightsail_domain_entry" "record1" {
  domain_name = var.domain_name
  name        = var.project_name
  type        = "A"
  target      = aws_lightsail_static_ip.static_ip.ip_address
}

resource "aws_lightsail_domain_entry" "record2" {
  domain_name = var.domain_name
  name        = "www.${var.project_name}"
  type        = "A"
  target      = aws_lightsail_static_ip.static_ip.ip_address
}

# Attach the Instances to the Load Balancer
resource "aws_lightsail_lb_attachment" "lb01Aattach" {
  lb_name       = var.lb_name
  instance_name = aws_lightsail_instance.lightsail_instance.id
}