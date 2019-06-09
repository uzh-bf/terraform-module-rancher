resource "aws_route53_record" "lb_master" {
  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}master.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${hcloud_server.lb.*.ipv4_address}",
  ]
}

resource "aws_route53_record" "lb_worker" {
  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}worker.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${hcloud_floating_ip.lb_worker.*.ip_address}",
  ]
}

resource "aws_route53_record" "lb" {
  count = "${length(var.hcloud_lb_nodes)}"

  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}lb-0${count.index + 1}.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${element(hcloud_server.lb.*.ipv4_address, count.index)}",
  ]
}

resource "hcloud_server" "lb" {
  count = "${length(var.hcloud_lb_nodes)}"

  image       = "${var.hcloud_base_image}"
  name        = "${var.prefix}lb-0${count.index + 1}.${var.base_domain}"
  location    = "${element(var.hcloud_lb_nodes, count.index)}"
  server_type = "${var.hcloud_lb_size}"
  ssh_keys    = "${var.hcloud_ssh_keys}"
}

resource "hcloud_floating_ip" "lb_worker" {
  count = "${length(var.hcloud_lb_nodes)}"

  type      = "ipv4"
  server_id = "${element(hcloud_server.lb.*.id, count.index)}"
}
