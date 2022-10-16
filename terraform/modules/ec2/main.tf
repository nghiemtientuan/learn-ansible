# get ubuntu ami
data "aws_ami" "server_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.server_ami_filter_name]
  }

  owners = ["099720109477", "amazon"] # Canonical Ubuntu AWS account id
}

locals {
  key_pair_name = "${var.ec_name}_key_pair.pem"
  user_name = var.os_name == "ubuntuOS" ? "ubuntu" : "ec2-user"
  inline_remote_exec = var.os_name == "ubuntuOS" ? [
    "sudo apt update -y",
    "sudo apt install -y software-properties-common",
    "sudo apt-add-repository --yes --update ppa:ansible/ansible",
    "sudo apt install -y ansible"
  ] : [
    "sudo yum update -y",
    "sudo amazon-linux-extras install -y epel",
    "sudo yum install -y ansible"
  ]
}

resource "tls_private_key" "tls_private_key" {
  algorithm = "RSA"
}
resource "local_sensitive_file" "private_key" {
  filename        = "${path.cwd}/key_pairs/${local.key_pair_name}"
  content         = tls_private_key.tls_private_key.private_key_pem
  file_permission = "0400"
}
resource "aws_key_pair" "key_pair" {
  key_name   = "${var.ec_name}_key_pair"
  public_key = tls_private_key.tls_private_key.public_key_openssh
}

resource "aws_instance" "server_instance" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.sg.id]
  key_name               = aws_key_pair.key_pair.key_name
  tags = {
    Name = var.ec_name
  }

  provisioner "remote-exec" {
    # install ansible in ec2
    inline = local.inline_remote_exec

    connection {
      agent       = false
      type        = "ssh"
      user        = local.user_name
      private_key = tls_private_key.tls_private_key.private_key_pem
      host        = self.public_ip
    }
  }
}
