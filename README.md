# learn-ansible

# Requisite
Install ansible
```
    sudo apt update
    sudo apt install ansible
    ansible --version
```

# Guideline
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
