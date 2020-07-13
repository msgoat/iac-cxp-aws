# ----------------------------------------------------------------------------
# backend.tf
# Defines remote storage backend on AWS S3. Unfortunately we cannot use
# variables so we have to use hardcoded values to define AWS region,
# S3 bucket and Dynamo DB.
# ----------------------------------------------------------------------------

# make sure we store Terraform state remotely on S3
/*
terraform {
  backend "s3" {
    bucket = "tf-iac-at41tools"
    key = "terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
    dynamodb_table = "tf-iac-at41tools"
  }
}
*/