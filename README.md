# load-balancer

Load balancer in this repository are built using HA Proxy and Keep Alived on a Proxmox VE.
Some major purpose for this load balancer are to handle traffic for :
- Kubernetes Control Plane
- Argo CD 
- Ingress for Traefik

## Features

- High Availability Load Balancer using Virtual IP from Keep Alived
- Customizeable HA Proxy Load Balancer
- Automate infrastructure provisioning using Terraform
- Automate configuration management using Ansible

## Requirements

To be able to deploy the load balancer into your infrastructure environment, these are some files that need to be configured : 

- credential.auto.tfvars
```
proxmox_api = {
  token_id     = [PROXMOX-TOKEN-ID]
  token_secret = [PROXMOX-TOKEN-SECRET]
  url          = [PROXMOX-URL]
  debug        = true
}

sshkeys = [SSH-KEYS]
```
- variables.auto.tfvars
```
load_balancer_vm_detail = {
  lb-1 = {
    name = "lb-1"
    vmid = "501"
    ipconfig0 = "ip=[IP MASTER-LB]/24,gw=[IP GATEWAY-LB]"
    keepalived_state_path = "config/master/keepalived.conf"
  }
  lb-2 = {
    name = "lb-2"
    vmid = "502"
    ipconfig0 = "ip=[IP SLAVE-LB]/24,gw=[IP GATEWAY-LB]"
    keepalived_state_path = "config/slave/keepalived.conf"
  }
}
```

To be able to use the HA Proxy & KeepAlived properly, these are some files that need to be configured : 
- haproxy.conf
- master/keepalived.conf
- slave/keepalived.conf
- check_apiserver.sh


To be able to configured the deployed VM, these are some files that need to be configured :
- inventory.ini
```
[master-lb]
[IP MASTER-LB] ansible_ssh_private_key_file='~/.ssh/id_rsa' ansible_ssh_user=[USER]

[slave-lb]
[IP SLAVE-LB] ansible_ssh_private_key_file='~/.ssh/id_rsa' ansible_ssh_user=[USER]

[loadbalancers]
[IP MASTER-LB] ansible_ssh_private_key_file='~/.ssh/id_rsa' ansible_ssh_user=[USER]
[IP SLAVE-LB] ansible_ssh_private_key_file='~/.ssh/id_rsa' ansible_ssh_user=[USER]
```
- initial.yml

## Command
This is the command to deploy the VM into the Proxmox using Terraform : 
```
terraform init
```
```
terraform plan
```
```
terraform apply
```

This is the command to automate configure the deployed VM : 
```
cd ansible/
```
```
ansible-playbook -i inventory.ini initial.yml
```
