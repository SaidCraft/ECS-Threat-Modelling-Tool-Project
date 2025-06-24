terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }
  }

  backend "s3" {
    bucket = "ecs-s3-bucket-project"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }

}

provider "aws" {
  # Configuration options
}

