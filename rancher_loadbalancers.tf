resource "aws_route53_record" "lb_rancher" {
  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}rancher.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = ["${hcloud_server.lb.*.ipv4_address}"]
}

resource "aws_route53_record" "lb_apps" {
  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}apps.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = ["${hcloud_server.lb.*.ipv4_address}"]
}

resource "aws_route53_record" "lb" {
  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}lb-0${count.index + 1}.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${element(hcloud_server.lb.*.ipv4_address, count.index)}",
  ]
}

resource "hcloud_server" "lb" {
  count       = "${length(var.hcloud_lb_locations)}"
  image       = "${var.hcloud_base_image}"
  name        = "${var.prefix}lb-0${count.index + 1}.${var.base_domain}"
  location    = "${element(var.hcloud_lb_locations, count.index)}"
  server_type = "${var.hcloud_lb_size}"
  ssh_keys    = "${var.hcloud_ssh_keys}"
}
