# HETZNER CLOUD @ FSN
resource "aws_route53_record" "worker-fsn" {
  zone_id = "${var.aws_route53_zone}"
  count   = "${var.hcloud_worker_count_fsn}"
  name    = "${var.prefix}worker-fsn-0${count.index + 1}.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${element(hcloud_server.worker-fsn.*.ipv4_address, count.index)}",
  ]
}

resource "hcloud_server" "worker-fsn" {
  count       = "${var.hcloud_worker_count_fsn}"
  image       = "${var.hcloud_base_image}"
  name        = "${var.prefix}worker-fsn-0${count.index + 1}.${var.base_domain}"
  location    = "fsn1"
  server_type = "${var.hcloud_worker_size}"
  ssh_keys    = "${var.hcloud_ssh_keys}"
}

# HETZNER CLOUD @ NBG
resource "aws_route53_record" "worker-nbg" {
  zone_id = "${var.aws_route53_zone}"
  count   = "${var.hcloud_worker_count_nbg}"
  name    = "${var.prefix}worker-nbg-0${count.index + 1}.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${element(hcloud_server.worker-nbg.*.ipv4_address, count.index)}",
  ]
}

resource "hcloud_server" "worker-nbg" {
  count       = "${var.hcloud_worker_count_nbg}"
  image       = "${var.hcloud_base_image}"
  name        = "${var.prefix}worker-nbg-0${count.index + 1}.${var.base_domain}"
  location    = "nbg1"
  server_type = "${var.hcloud_worker_size}"
  ssh_keys    = "${var.hcloud_ssh_keys}"
}

# HETZNER CLOUD @ HEL
resource "aws_route53_record" "worker-hel" {
  zone_id = "${var.aws_route53_zone}"
  count   = "${var.hcloud_worker_count_hel}"
  name    = "${var.prefix}worker-hel-0${count.index + 1}.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${element(hcloud_server.worker-hel.*.ipv4_address, count.index)}",
  ]
}

resource "hcloud_server" "worker-hel" {
  count       = "${var.hcloud_worker_count_hel}"
  image       = "${var.hcloud_base_image}"
  name        = "${var.prefix}worker-hel-0${count.index + 1}.${var.base_domain}"
  location    = "hel1"
  server_type = "${var.hcloud_worker_size}"
  ssh_keys    = "${var.hcloud_ssh_keys}"
}

# EXOSCALE @ DK
resource "aws_route53_record" "worker-dk" {
  zone_id = "${var.aws_route53_zone}"
  count   = "${var.exoscale_worker_count_dk}"
  name    = "${var.prefix}worker-dk-0${count.index + 1}.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${element(exoscale_compute.worker-dk.*.ip_address, count.index)}",
  ]
}

resource "exoscale_compute" "worker-dk" {
  count           = "${var.exoscale_worker_count_dk}"
  display_name    = "${var.prefix}worker-dk-0${count.index + 1}"
  template        = "${var.exoscale_base_image}"
  size            = "${var.exoscale_worker_size}"
  key_pair        = "${var.exoscale_ssh_key}"
  disk_size       = "${var.exoscale_disk_size}"
  zone            = "ch-dk-2"
  security_groups = ["rancher-worker"]
}

# EXOSCALE @ GVA
resource "aws_route53_record" "worker-gva" {
  zone_id = "${var.aws_route53_zone}"
  count   = "${var.exoscale_worker_count_gva}"
  name    = "${var.prefix}worker-gva-0${count.index + 1}.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${element(exoscale_compute.worker-gva.*.ip_address, count.index)}",
  ]
}

resource "exoscale_compute" "worker-gva" {
  count           = "${var.exoscale_worker_count_gva}"
  display_name    = "${var.prefix}worker-gva-0${count.index + 1}"
  template        = "${var.exoscale_base_image}"
  size            = "${var.exoscale_worker_size}"
  key_pair        = "${var.exoscale_ssh_key}"
  disk_size       = "${var.exoscale_disk_size}"
  zone            = "ch-gva-2"
  security_groups = ["rancher-worker"]
}
