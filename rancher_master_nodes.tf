resource "aws_route53_record" "master-nodes" {
  zone_id = "${var.aws_route53_zone}"
  name    = "_http._tcp.${var.prefix}master-nodes.${var.base_domain}"
  type    = "SRV"
  ttl     = "300"

  records = [
    "${hcloud_server.master-01.ipv4_address}",
    "${hcloud_server.master-02.ipv4_address}",
    "${hcloud_server.master-03.ipv4_address}",
  ]
}

# MASTER 1
resource "aws_route53_record" "master-01" {
  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}master-01.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${hcloud_server.master-01.ipv4_address}",
  ]
}

resource "hcloud_server" "master-01" {
  image       = "${var.hcloud_base_image}"
  name        = "${var.prefix}master-01.${var.base_domain}"
  location    = "fsn1"
  server_type = "${var.hcloud_master_size}"
  ssh_keys    = "${var.hcloud_ssh_keys}"
}

# MASTER 2
resource "aws_route53_record" "master-02" {
  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}master-02.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${hcloud_server.master-02.ipv4_address}",
  ]
}

resource "hcloud_server" "master-02" {
  image       = "${var.hcloud_base_image}"
  name        = "${var.prefix}master-02.${var.base_domain}"
  location    = "nbg1"
  server_type = "${var.hcloud_master_size}"
  ssh_keys    = "${var.hcloud_ssh_keys}"
}

# MASTER 3
resource "aws_route53_record" "master-03" {
  zone_id = "${var.aws_route53_zone}"
  name    = "${var.prefix}master-03.${var.base_domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "${hcloud_server.master-03.ipv4_address}",
  ]
}

resource "hcloud_server" "master-03" {
  image       = "${var.hcloud_base_image}"
  name        = "${var.prefix}master-03.${var.base_domain}"
  location    = "hel1"
  server_type = "${var.hcloud_master_size}"
  ssh_keys    = "${var.hcloud_ssh_keys}"
}
