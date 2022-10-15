variable "sg" {
  description = "Security group for ec2"
  type        = any
}

variable "ec_name" {
  description = "The ec name"
  default     = "tuntun_server_1"
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
