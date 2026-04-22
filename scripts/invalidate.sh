#!/bin/bash
set -e

TF_DIR="../terraform"

DISTRIBUTION_ID=$(terraform -chdir=$TF_DIR output -raw cloudfront_distribution_id)

echo "Creating CloudFront invalidation for distribution: $DISTRIBUTION_ID"
aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths "/*"

echo "Invalidation request submitted."
