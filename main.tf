// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

# This is the main configuration file for the module
# This file is responsible for creating the resources

#specify the region to deploy the resources
provider "aws" {
  region = var.aws_region
}

resource "random_string" "string" {
  length  = var.length
  numeric = var.number
  special = var.special
}

# deploying an S3 bucket
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = var.s3_bucket_name
}

# uploading a file to the S3 bucket
resource "aws_s3_object" "my_s3_bucket_object" {
  bucket       = aws_s3_bucket.my_s3_bucket.id
  key          = var.s3_bucket_object_key
  source       = var.s3_bucket_object_source
  content_type = var.s3_bucket_content_type
}

# S3 bucket website configuration
resource "aws_s3_bucket_website_configuration" "my_s3_bucket_website" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  index_document {
    suffix = var.s3_bucket_index_document
  }
}

# S3 bucket public access block
# resource "aws_s3_bucket_public_access_block" "my_s3_bucket_public_access" {
#   bucket = aws_s3_bucket.my_s3_bucket.id

#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

# S3 bucket policy
# resource "aws_s3_bucket_policy" "my_s3_bucket_policy" {
#   bucket = aws_s3_bucket.my_s3_bucket.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid       = "PublicReadGetObject"
#         Effect    = "Allow"
#         Principal = "*"
#         Action    = [
#           "s3:GetObject"
#         ]
#         Resource  = [
#           "arn:aws:s3:::${var.s3_bucket_name}/*"
#         ]
#       }
#     ]
#   })
# }
