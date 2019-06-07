resource "exoscale_security_group" "rancher_master" {
  name        = "rancher-master"
  description = "Security group that applies to all master nodes in the Rancher cluster."
}

resource "exoscale_security_group" "rancher_worker" {
  name        = "rancher-worker"
  description = "Security group that applies to all worker nodes in the Rancher cluster."
}

resource "exoscale_security_group_rules" "rancher_master_rules" {
  security_group_id = "${exoscale_security_group.rancher_master.id}"

  ingress {
    description              = "ssh"
    protocol                 = "TCP"
    cidr_list                = ["0.0.0.0/32"]
    ports                    = ["22"]
    user_security_group_list = []
  }

  ingress {
    description              = "master-to-master communication over tcp"
    protocol                 = "TCP"
    cidr_list                = ["${formatlist("%s/32", list(hcloud_server.master-01.ipv4_address, hcloud_server.master-02.ipv4_address, hcloud_server.master-03.ipv4_address))}"]
    ports                    = ["2376", "2379", "2380", "6443", "9796", "10250", "30000-32767"]
    user_security_group_list = ["rancher-master"]
  }

  ingress {
    description              = "master-to-master communication over udp"
    protocol                 = "UDP"
    cidr_list                = ["${formatlist("%s/32", list(hcloud_server.master-01.ipv4_address, hcloud_server.master-02.ipv4_address, hcloud_server.master-03.ipv4_address))}"]
    ports                    = ["8472", "30000-32767"]
    user_security_group_list = ["rancher-master"]
  }

  ingress {
    description              = "worker-to-master communication over tcp"
    protocol                 = "TCP"
    cidr_list                = ["${formatlist("%s/32", concat(hcloud_server.worker-fsn.*.ipv4_address, hcloud_server.worker-nbg.*.ipv4_address, hcloud_server.worker-hel.*.ipv4_address))}"]
    ports                    = ["2376", "6443", "9796", "30000-32767"]
    user_security_group_list = ["rancher-worker"]
  }

  ingress {
    description              = "worker-to-master communication over udp"
    protocol                 = "UDP"
    cidr_list                = ["${formatlist("%s/32", concat(hcloud_server.worker-fsn.*.ipv4_address, hcloud_server.worker-nbg.*.ipv4_address, hcloud_server.worker-hel.*.ipv4_address))}"]
    ports                    = ["8472", "30000-32767"]
    user_security_group_list = ["rancher-worker"]
  }
}

resource "exoscale_security_group_rules" "rancher_worker_rules" {
  security_group_id = "${exoscale_security_group.rancher_worker.id}"

  ingress {
    description              = "ssh"
    protocol                 = "TCP"
    cidr_list                = ["0.0.0.0/32"]
    ports                    = ["22"]
    user_security_group_list = []
  }

  ingress {
    description              = "worker-to-worker communication over tcp"
    protocol                 = "TCP"
    cidr_list                = ["${formatlist("%s/32", concat(hcloud_server.worker-fsn.*.ipv4_address, hcloud_server.worker-nbg.*.ipv4_address, hcloud_server.worker-hel.*.ipv4_address))}"]
    ports                    = ["2376", "9796", "30000-32767"]
    user_security_group_list = ["rancher-worker"]
  }

  ingress {
    description              = "worker-to-worker communication over udp"
    protocol                 = "UDP"
    cidr_list                = ["${formatlist("%s/32", concat(hcloud_server.worker-fsn.*.ipv4_address, hcloud_server.worker-nbg.*.ipv4_address, hcloud_server.worker-hel.*.ipv4_address))}"]
    ports                    = ["8472", "30000-32767"]
    user_security_group_list = ["rancher-worker"]
  }

  ingress {
    description              = "master-to-worker communication over tcp"
    protocol                 = "TCP"
    cidr_list                = ["${formatlist("%s/32", list(hcloud_server.master-01.ipv4_address, hcloud_server.master-02.ipv4_address, hcloud_server.master-03.ipv4_address))}"]
    ports                    = ["2376", "9796", "10250", "30000-32767"]
    user_security_group_list = ["rancher-master"]
  }

  ingress {
    description              = "master-to-worker communication over udp"
    protocol                 = "UDP"
    cidr_list                = ["${formatlist("%s/32", list(hcloud_server.master-01.ipv4_address, hcloud_server.master-02.ipv4_address, hcloud_server.master-03.ipv4_address))}"]
    ports                    = ["8472", "30000-32767"]
    user_security_group_list = ["rancher-master"]
  }
}
