variable "node_count" {
  description = "Cantidad de servidores para el clúster"
  default     = 2
}

variable "user" {
  default = "osboxes"
}

variable "password" {
  default = "osboxes.org" 
}

variable "ova_path" {
  default = "./Ubuntu-24.04-64bit-VB.ova" 
}

variable "network_adapter" {
  description = "Tu tarjeta de red activa en Windows"
  default     = "Realtek RTL8822CE 802.11ac PCIe Adapter" 
}
variable "servidores_ips" {
  type    = list(string)
  default = ["192.168.1.14", "192.168.1.15", "192.168.1.9"] 
}