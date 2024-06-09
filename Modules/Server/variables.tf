variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "project_name" {
  description = "Project Name"
  type        = string
}
variable "bundle_id" {
  type        = string
  default     = "nano_2_0"
  description = "Options for instance size"
}
variable "lightsail_blueprint" {
  type        = string
  description = "The ID for a virtual instance image"
}

variable "secretFile" {
  type        = string
  description = "The secret file that contains the ENV Secret"
  default     = "secret.txt"
}

variable "domain_name" {
  description = "The Domain that we're using"
  type        = string
}

# Taken as an output from the Domain Module
variable "lb_name" {
  type = string
}