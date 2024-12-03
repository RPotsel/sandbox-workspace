variable "volume_pool_name" {
  description = "Volume Storage Pool"
  type        = string
  default     = "default"
}

variable "image_source" {
  description = "Volume Image Source"
  type        = string
  default     = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-disk-kvm.img"
}

variable "volume_size" {
  description = "Volume Size in Bytes"
  type        = number
  default     = 10 * 1024 * 1024 * 1024 # 10GB
}

variable "hostname_prefix" {
  description = "Guest Hostname"
  type        = string
  default     = "hostname"
}

variable "instance_memory" {
  description = "Memory in Megabytes"
  type        = number
  default     = 512
}

variable "instance_vcpu" {
  description = "Number of vCPUs"
  type        = string
  default     = "2"
}

variable "instance_network" {
  description = "Name of Libvirt Network"
  type        = string
  default     = "default"
}

variable "network_config_file" {
  description = "(Optional) cloud-init network-config data file"
  type        = string
  default     = ""
}

variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 1
}

# CloudInit Variables
variable "user_name" {
  description = "(Optional) Provide username for creation on instance with cloud-init"
  type        = string
  default     = "linux"
}

## openssl passwd -1 Password
variable "user_passwd" {
  description = "(Optional) Provide password for creation on instance with cloud-init for user"
  type        = string
  default     = ""
}

variable "ssh_authorized_key" {
  description = "(Optional) Provide SSH Public Key on instance with cloud-init for user"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "package_list" {
  description = "List of additional packages to install"
  type        = list(string)
  default = [
    "qemu-guest-agent"
  ]
}
