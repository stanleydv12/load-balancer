variable "proxmox_api" {
    type = object({
        url = string
        token_id = string
        token_secret = string
        debug = bool
    })
}

variable "load_balancer_vm_detail" {
    type = map(object({
        name = string
        vmid = string
        ipconfig0 = string
        keepalived_state_path = string
    }))
}

variable "sshkeys" {
  type      = string
  sensitive = true
}