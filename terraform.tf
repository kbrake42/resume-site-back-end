terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket         = "kdb-resume-tfstate"
    key            = "app-state"
    region         = "us-east-1"
    dynamodb_table = "terraform-resume-state"
  }

  required_version = "= 1.2.5"

}