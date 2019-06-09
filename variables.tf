variable "prefix" {}
variable "base_domain" {}
variable "aws_route53_zone" {}

variable "setup_certmgr" {
  default = "0"
}

variable "setup_exoscale" {
  default = "0"
}

variable "hcloud_lb_nodes" {
  default = []
}

variable "hcloud_master_nodes" {
  default = ["fsn1", "nbg1", "hel1"]
}

variable "hcloud_worker_nodes" {
  default = []
}

variable "hcloud_lb_size" {
  default = "cx11"
}

variable "hcloud_ssh_keys" {
  type = "list"
}

variable "hcloud_base_image" {
  default = "ubuntu-18.04"
}

variable "hcloud_master_size" {
  default = "cx21"
}

variable "hcloud_worker_size" {
  default = "cx41"
}

variable "exoscale_ssh_key" {}

variable "exoscale_base_image" {
  default = "Linux Ubuntu 18.04 LTS 64-bit"
}

variable "exoscale_disk_size" {
  default = "20"
}

variable "exoscale_worker_size" {
  default = "Small"
}

variable "exoscale_worker_nodes" {
  default = []
}
