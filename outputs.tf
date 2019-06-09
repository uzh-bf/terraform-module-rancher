output "aws_route53_record_lb_master" {
  value = "${aws_route53_record.lb_master.name}"
}

output "aws_route53_record_lb_worker" {
  value = "${aws_route53_record.lb_worker.name}"
}

output "cert_manager_access_key" {
  value = "${aws_iam_access_key.cert_manager_credentials.*.id}"
}

output "cert_manager_secret_key" {
  value = "${aws_iam_access_key.cert_manager_credentials.*.secret}"
}
