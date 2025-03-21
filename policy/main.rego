package main

import input as tfplan

# Helper to find all S3 buckets in plan
s3_buckets[bucket] {
    bucket := tfplan.resource_changes[_]
    bucket.type == "aws_s3_bucket"
}

# Helper to find all S3 objects in plan
s3_objects[object] {
    object := tfplan.resource_changes[_]
    object.type == "aws_s3_object"
}

# Helper to find all S3 website configurations in plan
s3_website_configs[config] {
    config := tfplan.resource_changes[_]
    config.type == "aws_s3_bucket_website_configuration"
}

# Deny if no S3 bucket is present in the plan
deny[msg] {
    count(s3_buckets) == 0
    msg = "No S3 bucket resource found in Terraform plan"
}

# Deny if no S3 object is present in the plan
deny[msg] {
    count(s3_objects) == 0
    msg = "No S3 object resource found in Terraform plan"
}

# Deny if no S3 website configuration is present in the plan
deny[msg] {
    count(s3_website_configs) == 0
    msg = "No S3 website configuration found in Terraform plan"
}

# Validate S3 bucket configuration
deny[msg] {
    bucket := s3_buckets[_]
    not bucket.change.after.bucket
    msg = sprintf("S3 bucket '%v' is missing required 'bucket' attribute", [bucket.address])
}

# Validate S3 object configuration
deny[msg] {
    object := s3_objects[_]
    not object.change.after.key
    msg = sprintf("S3 object '%v' is missing required 'key' attribute", [object.address])
}

# Validate S3 object source
deny[msg] {
    object := s3_objects[_]
    not object.change.after.source
    msg = sprintf("S3 object '%v' is missing required 'source' attribute", [object.address])
}

# Validate S3 website configuration
deny[msg] {
    config := s3_website_configs[_]
    not config.change.after.index_document
    msg = sprintf("S3 website configuration '%v' is missing required 'index_document' attribute", [config.address])
}
