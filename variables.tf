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

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "ami_instance" {
  description = "AMI ID of the EC2 instance"
  type        = string
  default     = "ami-088b41ffb0933423f"
}

variable "ec2_instance_type" {
  description = "AWS EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ec2_instance_tags" {
  description = "Tags for ec2 instance resource"
  type        = map(string)
  default = {
    Name = "ExampleAppServerInstance"
  }
}
