resource "libvirt_volume" "base_volume" {
  name   = format("${var.hostname_prefix}-base.qcow2")
  pool   = var.volume_pool_name
  source = var.image_source
  format = "qcow2"
}

resource "libvirt_volume" "root" {
  count          = var.instance_count
  name           = format("${var.hostname_prefix}%02d.qcow2", count.index+1)
  pool           = var.volume_pool_name
  base_volume_id = libvirt_volume.base_volume.id
  size           = var.volume_size
}

resource "libvirt_cloudinit_disk" "commoninit" {
  count          = var.instance_count
  name           = format("${var.hostname_prefix}%02d-init.iso", count.index+1)
  pool           = var.volume_pool_name

  user_data      = templatefile(fileexists("./templates/cloud_init.yml.tftpl") ? "./templates/cloud_init.yml.tftpl" : "${path.module}/templates/cloud_init.yml.tftpl", {
    user_name          = var.user_name
    user_passwd        = var.user_passwd
    ssh_authorized_key = file("${var.ssh_authorized_key}")
    package_list       = var.package_list
  })

  meta_data      = templatefile("${path.module}/templates/meta_data.yml.tftpl", {
    hostname = format("${var.hostname_prefix}%02d", count.index+1)
  })

  # network_config = var.network_config_file != "" ? file(var.network_config_file) : ""
  # network_config = file("${path.module}/templates/network_config.yml")
}