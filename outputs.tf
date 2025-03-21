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

output "string" {
  value = random_string.string.result
}

# s3 bucket website endpoint
output "s3_website" {
  value = aws_s3_bucket_website_configuration.my_s3_bucket_website.website_endpoint
}

# s3 bucket arn
output "s3_bucket_arn" {
  value = aws_s3_bucket.my_s3_bucket.arn
}

# s3 bucket id
output "s3_bucket_id" {
  value = aws_s3_bucket.my_s3_bucket.id
}
