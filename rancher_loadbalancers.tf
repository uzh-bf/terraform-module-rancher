# GLOBAL ALIAS
resource "aws_route53_record" "lb" {
  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}rancher.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${hcloud_server.lb-01.ipv4_address}",
    "${hcloud_server.lb-02.ipv4_address}",
  ]
}

# LB 1
resource "aws_route53_record" "lb-01" {
  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}lb-01.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${hcloud_server.lb-01.ipv4_address}",
  ]
}

resource "hcloud_server" "lb-01" {
  image       = "${var.hcloud_base_image}"
  name        = "${var.prefix}lb-01.${var.base_domain}"
  location    = "fsn1"
  server_type = "cx11"
  ssh_keys    = "${var.hcloud_ssh_keys}"
}

# LB 2
resource "aws_route53_record" "lb-02" {
  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}lb-02.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${hcloud_server.lb-02.ipv4_address}",
  ]
}

resource "hcloud_server" "lb-02" {
  image       = "${var.hcloud_base_image}"
  name        = "${var.prefix}lb-02.${var.base_domain}"
  location    = "nbg1"
  server_type = "cx11"
  ssh_keys    = "${var.hcloud_ssh_keys}"
}
