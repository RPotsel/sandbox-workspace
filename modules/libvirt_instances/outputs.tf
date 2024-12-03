output "instance_names" {
  value = libvirt_domain.instance[*].name
  description = "Instance Names"
}

output "instance_ip4s" {
  value = try(libvirt_domain.instance[*].network_interface[0].addresses[0], "null")
  description = "Interface IPs"
}
