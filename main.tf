resource "random_string" "bucket_name" {
  length  = 16
  special = false
  upper   = false
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result

  tags = {
    UserUuid        = var.user_uuid
    Environment = "Dev"
  }
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
