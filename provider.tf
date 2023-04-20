provider "aws" {
  region  = "ap-south-1" # Don't change the region
}

# Add your S3 backend configuration here - done?
terraform {
  backend "s3" {
    bucket = "3.devops.candidate.exam"
    key    = "mark.currin"
    region = "ap-south-1"
  }
}