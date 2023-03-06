resource "proxmox_vm_qemu" "load_balancer_vm" {
  for_each = var.load_balancer_vm_detail

  name        = each.value.name
  vmid        = each.value.vmid
  desc        = "HA Proxy Load Balancer"
  target_node = [PROXMOX VE SERVER NAME]

  clone = [BASE VM IMAGE]
  agent = 0

  cores   = 2
  sockets = 1
  cpu    = "kvm64"
  memory = 2048

  full_clone = true

  ipconfig0 = each.value["ipconfig0"]

  ssh_user = [USER]
  ciuser     = [USER]
  cipassword = [PASSWORD]
  sshkeys = var.sshkeys

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = "10G"
  }

  connection {
    type     = "ssh"
    user     = [USER]
    password = [PASSWORD]
    host     = self.ssh_host
  }

  # provisioner "remote-exec" {
  #   when = create
  #   inline = [
  #     "sudo reboot"
  #   ]
  # }
}
