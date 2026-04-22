output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.site_bucket.bucket
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.site_cdn.id
}

output "cloudfront_domain_name" {
  description = "CloudFront domain name"
  value       = aws_cloudfront_distribution.site_cdn.domain_name
}

output "website_url" {
  description = "Website URL via CloudFront"
  value       = "https://${aws_cloudfront_distribution.site_cdn.domain_name}"
}
