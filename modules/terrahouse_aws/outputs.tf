output "bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
  
}
output "website_endopint" {
  value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}

output "content_version" {
  value = terraform_data.content_version.output
}