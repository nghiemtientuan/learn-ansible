output "server_1_ip" {
  value = module.ec2_server_1.public_ip
}

output "server_2_ip" {
  value = module.ec2_server_2.public_ip
}
