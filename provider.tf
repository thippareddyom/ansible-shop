provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "raws-devops-b78"
    key = "env-dev/state.tf"
    region = "us-east-1"
  }
}