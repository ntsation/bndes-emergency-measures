#!/bin/bash
# Script to set up Terraform backend (S3 + DynamoDB)

set -e

# Configuration
BACKEND_BUCKET="bndes-emergency-measures-terraform-state"
DYNAMODB_TABLE="bndes-emergency-measures-terraform-locks"
REGION="us-east-1"

echo "Setting up Terraform backend infrastructure..."
echo "Region: $REGION"
echo "S3 Bucket: $BACKEND_BUCKET"
echo "DynamoDB Table: $DYNAMODB_TABLE"

# Check if bucket exists
if aws s3 ls "s3://$BACKEND_BUCKET" 2>&1 | grep -q 'NoSuchBucket'
then
    echo "Creating S3 bucket for Terraform state..."
    aws s3api create-bucket \
        --bucket "$BACKEND_BUCKET" \
        --region "$REGION" \
        --create-bucket-configuration LocationConstraint="$REGION"
    
    # Enable versioning
    aws s3api put-bucket-versioning \
        --bucket "$BACKEND_BUCKET" \
        --versioning-configuration Status=Enabled
    
    # Enable encryption
    aws s3api put-bucket-encryption \
        --bucket "$BACKEND_BUCKET" \
        --server-side-encryption-configuration '{
            "Rules": [{
                "ApplyServerSideEncryptionByDefault": {
                    "SSEAlgorithm": "AES256"
                }
            }]
        }'
    
    # Block public access
    aws s3api put-public-access-block \
        --bucket "$BACKEND_BUCKET" \
        --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
    
    echo "S3 bucket created and configured successfully!"
else
    echo "S3 bucket already exists, skipping creation."
fi

# Check if DynamoDB table exists
if ! aws dynamodb describe-table --table-name "$DYNAMODB_TABLE" --region "$REGION" >/dev/null 2>&1
then
    echo "Creating DynamoDB table for state locking..."
    aws dynamodb create-table \
        --table-name "$DYNAMODB_TABLE" \
        --attribute-definitions AttributeName=LockID,Type=S \
        --key-schema AttributeName=LockID,KeyType=HASH \
        --billing-mode PAY_PER_REQUEST \
        --region "$REGION"
    
    echo "DynamoDB table created successfully!"
else
    echo "DynamoDB table already exists, skipping creation."
fi

echo ""
echo "Terraform backend setup completed!"
echo ""
echo "Update your GitHub secrets with the following:"
echo "TF_STATE_BUCKET=$BACKEND_BUCKET"
echo ""
echo "You can now run: terraform init"