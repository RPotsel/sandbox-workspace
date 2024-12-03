# Terraform output is broken in 0.7.4. Can't pull the IP address information
# ou can work around this by setting the version of the plugin to 0.7.1.
# https://github.com/dmacvicar/terraform-provider-libvirt/issues/1037

terraform {
  required_version = ">= 1.4.0"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}
