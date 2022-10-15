# get ubuntu ami
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical Ubuntu AWS account id
}

locals {
  key_pair_name = "${var.ec_name}_key_pair.pem"
  user_name = "ubuntu"
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

resource "aws_instance" "ubuntu" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.sg.id]
  key_name               = aws_key_pair.key_pair.key_name
  tags = {
    Name = var.ec_name
  }

  provisioner "remote-exec" {
    # install ansible in ec2
    inline = [
      "sudo apt update -y",
      "sudo apt install -y software-properties-common",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt install -y ansible"
    ]

    connection {
      type        = "ssh"
      user        = local.user_name
      private_key = tls_private_key.tls_private_key.private_key_pem
      host        = self.public_ip
    }
  }
}
