resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  tags = {
    UserUuid        = var.user_uuid
    Environment = "Dev"
  }
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
