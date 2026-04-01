resource "virtualbox_vm" "mamaya_nodes" {
  count     = var.node_count
  name      = "srv-mamaya-${count.index + 1}"
  image     = var.ova_path
  cpus      = 1
  memory    = "1024 mib"

  network_adapter {
    type           = "bridged"
    host_interface = var.network_adapter
  }
} 

resource "null_resource" "configuracion_mamaya" {
  count      = var.node_count
  depends_on = [virtualbox_vm.mamaya_nodes] 
  
connection {
  type     = "ssh"
  user     = var.user
  password = var.password
 
  host     = var.servidores_ips[count.index] 
  timeout  = "5m"
}

  provisioner "remote-exec" {
    inline = [
      "echo '${var.password}' | sudo -S apt-get update -y",
      "echo '${var.password}' | sudo -S apt-get install -y ufw nodejs mysql-server",
      "echo '${var.password}' | sudo -S ufw allow 22/tcp",
      "echo '${var.password}' | sudo -S ufw allow 80/tcp",
      "echo '${var.password}' | sudo -S ufw --force enable"
    ]
  }
}