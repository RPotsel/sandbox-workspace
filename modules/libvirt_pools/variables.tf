variable "volume_pool_name" {
  description = "Volume Storage Pool"
  type        = string
  default     = "default"
}

variable "volume_pool_path" {
  description = "Volume Storage Pool Path"
  type        = string
  default     = "/var/lib/libvirt/default"
}
