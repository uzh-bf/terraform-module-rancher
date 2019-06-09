resource "aws_route53_record" "master" {
  count = "${length(var.hcloud_master_nodes)}"

  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}master-0${count.index + 1}.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${element(hcloud_server.master.*.ipv4_address, count.index)}",
  ]
}

resource "hcloud_server" "master" {
  count = "${length(var.hcloud_master_nodes)}"

  image       = "${var.hcloud_base_image}"
  name        = "${var.prefix}master-0${count.index + 1}.${var.base_domain}"
  location    = "${element(var.hcloud_master_nodes, count.index)}"
  server_type = "${var.hcloud_master_size}"
  ssh_keys    = "${var.hcloud_ssh_keys}"
}

resource "aws_route53_record" "master_nodes" {
  zone_id = "${var.aws_route53_zone}"
  name    = "_http._tcp.${var.prefix}master-nodes.${var.base_domain}"
  type    = "SRV"
  ttl     = "300"

  records = ["${concat(
    formatlist("10 1 80 %s", hcloud_server.master.*.ipv4_address),
    formatlist("10 1 443 %s", hcloud_server.master.*.ipv4_address)
  )}"]
}
