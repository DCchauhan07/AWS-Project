#!/bin/bash
set -e

APP_DIR="../app"
TF_DIR="../terraform"

BUCKET_NAME=$(terraform -chdir=$TF_DIR output -raw s3_bucket_name)

echo "Deploying static files to S3 bucket: $BUCKET_NAME"
aws s3 sync $APP_DIR s3://$BUCKET_NAME --delete

echo "Deployment completed successfully."
