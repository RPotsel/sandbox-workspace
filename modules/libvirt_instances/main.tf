resource "libvirt_domain" "instance" {
  count  = var.instance_count
  memory = var.instance_memory
  vcpu   = var.instance_vcpu
  name   = format("${var.hostname_prefix}%02d", count.index+1)

  # arch = "x86_64"
  # Chipset
  machine = "q35"

  qemu_agent = true
  # autostart  = true

  cpu {
    mode = "host-passthrough"
  }

  disk {
    volume_id = element(libvirt_volume.root[*].id, count.index)
  }

  disk {
    # volume_id = split(";", libvirt_cloudinit_disk.commoninit.id)[0]
    volume_id = split(";", element(libvirt_cloudinit_disk.commoninit[*].id, count.index))[0]
  }

  # cloudinit = libvirt_cloudinit_disk.commoninit.id

  # Change bus cdrom to sata
  # sudo apt install xsltproc
  # xml {
  #   xslt = file("${path.module}/templates/cdrom-model.xsl")
  # }

  network_interface {
    network_name = var.instance_network
    wait_for_lease = true
  }

  ## Makes the tty0 available via `virsh console`
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

  lifecycle {
    ignore_changes = [
      network_interface,
    ]
  }

}

# IPs: use wait_for_lease true or after creation use terraform refresh and terraform show for the ips of domain
