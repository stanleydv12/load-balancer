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