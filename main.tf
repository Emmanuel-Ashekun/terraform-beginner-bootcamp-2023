terraform {
#   cloud {
#     organization = "emmyash-demo1"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "5.23.1"
#     }
#   }
# }

}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
