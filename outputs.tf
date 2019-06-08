output "aws_route53_record_lb_rancher" {
  value = "${aws_route53_record.lb_rancher.name}"
}

output "aws_route53_record_lb_apps" {
  value = "${aws_route53_record.lb_apps.name}"
}

output "aws_route53_record_lb_zone_id" {
  value = "${aws_route53_record.lb_all.zone_id}"
}

output "cert_manager_access_key" {
  value = "${aws_iam_access_key.cert_manager_credentials.id}"
}

output "cert_manager_secret_key" {
  value = "${aws_iam_access_key.cert_manager_credentials.secret}"
}
