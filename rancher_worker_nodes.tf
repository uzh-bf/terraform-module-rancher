resource "aws_route53_record" "hcloud_worker" {
  count = "${length(var.hcloud_worker_nodes)}"

  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}worker-0${count.index + 1}.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${element(hcloud_server.worker.*.ipv4_address, count.index)}",
  ]
}

resource "hcloud_server" "worker" {
  count = "${length(var.hcloud_worker_nodes)}"

  image       = "${var.hcloud_base_image}"
  name        = "${var.prefix}worker-0${count.index + 1}.${var.base_domain}"
  location    = "${element(var.hcloud_worker_nodes, count.index)}"
  server_type = "${var.hcloud_worker_size}"
  ssh_keys    = "${var.hcloud_ssh_keys}"
}

resource "aws_route53_record" "exoscale_worker" {
  count = "${length(var.exoscale_worker_nodes)}"

  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}worker-1${count.index + 1}.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${element(exoscale_compute.worker.*.ip_address, count.index)}",
  ]
}

resource "exoscale_compute" "worker" {
  count = "${length(var.exoscale_worker_nodes)}"

  display_name = "${var.prefix}worker-1${count.index + 1}"
  template     = "${var.exoscale_base_image}"
  size         = "${var.exoscale_worker_size}"
  key_pair     = "${var.exoscale_ssh_key}"
  disk_size    = "${var.exoscale_disk_size}"
  zone         = "${element(var.exoscale_worker_nodes, count.index)}" # ch-dk-2 or ch-gva-2

  security_groups = [
    "rancher-worker",
  ]
}

resource "aws_route53_record" "worker_nodes" {
  count = "${length(concat(var.hcloud_worker_nodes, var.exoscale_worker_nodes)) > 0 ? 1 : 0}"

  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}workers.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${concat(hcloud_server.worker.*.ipv4_address, exoscale_compute.worker.*.ip_address)}",
  ]
}

resource "aws_route53_record" "worker_nodes_srv" {
  count = "${length(concat(var.hcloud_worker_nodes, var.exoscale_worker_nodes)) > 0 ? 1 : 0}"

  zone_id = "${var.aws_route53_zone}"
  name    = "_http._tcp.${var.prefix}worker-nodes.${var.base_domain}"
  type    = "SRV"
  ttl     = "300"

  records = "${concat(
    formatlist("10 1 80 %s", concat(hcloud_server.worker.*.ipv4_address, exoscale_compute.worker.*.ip_address)),
    formatlist("10 1 443 %s", concat(hcloud_server.worker.*.ipv4_address, exoscale_compute.worker.*.ip_address)),
  )}"
}
