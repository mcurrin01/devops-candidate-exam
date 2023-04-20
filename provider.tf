provider "aws" {
  region  = "ap-south-1" # Don't change the region
}

# Add your S3 backend configuration here - done?
resource "aws_s3_bucket" "3.devops.candidate.exam" {
Bucket = "3.devops.candidate.exam"
Region = "ap-south-1"
Key = "mark.currin"
}