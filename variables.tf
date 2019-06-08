variable "prefix" {}
variable "base_domain" {}
variable "aws_route53_zone" {}

variable "hcloud_lb_locations" {
  type = "list"
}

variable "hcloud_lb_size" {}

variable "hcloud_ssh_keys" {
  type = "list"
}

variable "hcloud_base_image" {}
variable "hcloud_worker_count_fsn" {}
variable "hcloud_worker_count_nbg" {}
variable "hcloud_worker_count_hel" {}
variable "hcloud_master_size" {}
variable "hcloud_worker_size" {}
variable "exoscale_ssh_key" {}
variable "exoscale_base_image" {}
variable "exoscale_disk_size" {}
variable "exoscale_worker_size" {}
variable "exoscale_worker_count_dk" {}
variable "exoscale_worker_count_gva" {}
