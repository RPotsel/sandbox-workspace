resource "libvirt_pool" "pool" {
  name = var.volume_pool_name
  path = var.volume_pool_path
  type = "dir"
}
