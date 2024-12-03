provider "libvirt" {
  uri = local.config.libvirt_uri
}

module "pool" {
  for_each = { for x in local.config.pools : x.name => x }
  source = "../modules/libvirt_pools"

  volume_pool_name = each.value.name
  volume_pool_path = each.value.path
}

module "instance" {
  for_each = { for x in local.config.instances : x.name => x }
  source = "../modules/libvirt_instances"

  instance_count     = each.value.count
  instance_memory    = each.value.memory
  instance_vcpu      = each.value.vcpu
  instance_network   = each.value.network
  hostname_prefix    = each.value.name
  image_source       = each.value.image_source
  volume_pool_name   = each.value.pool
  volume_size        = each.value.volume_size
  user_name          = each.value.user_name
  user_passwd        = each.value.user_passwd
  ssh_authorized_key = each.value.ssh_authorized_key

  depends_on = [module.pool]
}

output "output_data" {
  value = module.instance
}
