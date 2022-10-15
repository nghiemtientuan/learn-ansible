variable "region" {
  type = string
  default = "ap-northeast-1"
}

variable "project" {
  description = "The project name to use for unique resource naming"
  default     = "tuntun-ansible"
  type        = string
}

variable "instance_type" {
  type = string
  description = "Instance type of the EC2"
  default = "t2.micro"

  validation {
    condition = contains(["t2.micro", "t3.small"], var.instance_type)
    error_message = "Value not allow."
  }
}
