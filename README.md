# learn-ansible

# Requisite
Install ansible
```
    sudo apt update
    sudo apt install ansible
    ansible --version
```

# Building System
```
    export AWS_PROFILE=orderr_dev_tda_northeast
    terraform init
    terraform plan
    terraform apply
    terraform destroy
```
Copy IPs output

# Guideline
https://viblo.asia/p/phan-1-tim-hieu-ve-ansible-4dbZNxv85YM

https://github.com/ansible/ansible-examples/tree/master/lamp_simple

https://github.com/chrisanthropic/ansible-aws-template

# Setup
- inventory: edit /etc/ansible/hosts
- ping server:
```
    // Ping all
    ansible all -m ping
    ansible -i [hosts_path] all -m ping
    
    // Ping 1 group
    ansible all -m ping --limit [groupName]
    ansible -i [hosts_path] all -m ping --limit [groupName]
```
