provider "aws" {
  region  = "us-east-1"
  profile = "devops-challenge"
  default_tags {
    tags = {
      Project = "devops-challenge"
    }
  }
}