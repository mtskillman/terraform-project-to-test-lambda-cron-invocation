terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  alias = "us-east-1"

  region = "us-east-1"
}

provider "aws" {
  alias = "us-west-2"

  region = "us-west-2"
}

provider "aws" {
  alias = "eu-west-1"

  region = "eu-west-1"
}

provider "aws" {
  alias = "eu-central-1"

  region = "eu-central-1"
}

provider "aws" {
  alias = "ap-northeast-1"

  region = "ap-northeast-1"
}
