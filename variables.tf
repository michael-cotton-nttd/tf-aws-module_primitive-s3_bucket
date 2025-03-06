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

# This is where we define the input variables for the module
# These variables are used to parameterize our config and pass the values to the module

variable "length" {
  type    = number
  default = 24
}

variable "number" {
  type    = bool
  default = true
}

variable "special" {
  type    = bool
  default = false
}
# AWS region
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

# S3 bucket name
variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "bmc-initial-s3-bucket"
}

# S3 bucket object key
variable "s3_bucket_object_key" {
  description = "Key of the S3 bucket object"
  type        = string
  default     = "index.html"
}

# S3 bucket object source - file to upload
variable "s3_bucket_object_source" {
  description = "Source of the S3 bucket object"
  type        = string
  default     = "src/index.html"
}

# S3 bucket object content type - MIME type
variable "s3_bucket_content_type" {
  description = "Content type of the S3 bucket object"
  type        = string
  default     = "text/html"
}

# S3 bucket index document aka the "homepage"
variable "s3_bucket_index_document" {
  description = "Index document for the S3 bucket"
  type        = string
  default     = "index.html"
}
