output "bucket_name" {
    description = "bucketname for our static website"
    value = module.terrahouse_aws
}

output "s3_website_endopint" {
    value = module.terrahouse_aws.website_endopint
    description = "S3 static website hosting endpoint"
}

output "content_version" {
  value = var.content_version
}

output "cloudfront_url" {
  description = "the Cloudfront Distribution Name"
  value = module.terrahouse_aws.cloudfront_url
}