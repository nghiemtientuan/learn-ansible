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
  ec_name       = "${var.project}_1"
  instance_type = var.instance_type
}

module "ec2_server_2" {
  source = "./modules/ec2"

  sg            = module.security_group.sg
  ec_name       = "${var.project}_2"
  instance_type = var.instance_type
}
