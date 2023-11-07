terraform {
 # cloud {
  #  organization = "emmyash-demo1"

#    workspaces {
 #     name = "terra-house-1"
  #  }
  #}
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.1"
    }
  }
}

provider "aws" {
  # Configuration options
}


provider "random" {
  # Configuration options
}