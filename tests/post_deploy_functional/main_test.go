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

package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/launchbynttdata/lcaf-component-terratest/lib"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/launchbynttdata/lcaf-skeleton-terraform/tests/testimpl"
)

const (
	testConfigsExamplesFolderDefault = "../../examples"
	infraTFVarFileNameDefault        = "test.tfvars"
)

func TestTerraformApplyAndOutputs(t *testing.T) {
    t.Run("Validate Default Terraform Apply and Outputs", func(t *testing.T) {
        // Configure Terraform options with actual module path
        terraformOptions := &terraform.Options{
            TerraformDir: "../../",
        }

        // Clean up resources when the test is complete
        defer terraform.Destroy(t, terraformOptions)

        // Initialize and apply Terraform
        terraform.InitAndApply(t, terraformOptions)

        // Get all outputs
        outputs := terraform.OutputAll(t, terraformOptions)

        // Test bucket outputs
        t.Run("Bucket Outputs", func(t *testing.T) {
            bucketId, exists := outputs["s3_bucket_id"]
            assert.True(t, exists, "s3_bucket_id output should exist")
            assert.NotEmpty(t, bucketId, "s3_bucket_id should not be empty")
			assert.Equal(t, "bmc-initial-s3-bucket", bucketId, "s3_bucket_id should be the default bucket name")

            bucketArn, exists := outputs["s3_bucket_arn"]
            assert.True(t, exists, "s3_bucket_arn output should exist")
            assert.NotEmpty(t, bucketArn, "s3_bucket_arn should not be empty")
            assert.Contains(t, bucketArn.(string), "arn:aws:s3", )
			assert.Equal(t, "arn:aws:s3:::bmc-initial-s3-bucket", bucketArn, "s3_bucket_arn should be a valid S3 ARN")
        })

        // Test website outputs
        t.Run("Website Outputs", func(t *testing.T) {
            websiteEndpoint, exists := outputs["s3_website"]
            assert.True(t, exists, "s3_website output should exist")
            assert.NotEmpty(t, websiteEndpoint, "s3_website should not be empty")
            assert.Contains(t, websiteEndpoint.(string), "bmc-initial-s3-bucket.s3-website", "s3_website should be a valid S3 website URL")
        })
    })
}

func TestSkeletonModule(t *testing.T) {

	ctx := types.CreateTestContextBuilder().
		SetTestConfig(&testimpl.ThisTFModuleConfig{}).
		SetTestConfigFolderName(testConfigsExamplesFolderDefault).
		SetTestConfigFileName(infraTFVarFileNameDefault).
		Build()

	lib.RunSetupTestTeardown(t, *ctx, testimpl.TestComposableComplete)
}
