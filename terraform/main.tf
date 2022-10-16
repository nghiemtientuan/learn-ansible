# Configure the AWS Provider
provider "aws" {
  region = var.region
}

module "security_group" {
  source = "./modules/security_group"
}

module "ec2_server_1" {
  source = "./modules/ec2"

  sg            = module.security_group.sg
  ec_name       = "${var.project}_ubuntu"
  instance_type = var.instance_type
  server_ami_filter_name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  os_name = "ubuntuOS"
}

module "ec2_server_2" {
  source = "./modules/ec2"

  sg            = module.security_group.sg
  ec_name       = "${var.project}_centos"
  instance_type = var.instance_type
  server_ami_filter_name = "amzn2-ami-hvm-*-x86_64-ebs"
  os_name = "centOS"
}
