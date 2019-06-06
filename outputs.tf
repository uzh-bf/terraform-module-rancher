output "aws_route53_record_lb_name" {
  value = "${aws_route53_record.lb.name}"
}

output "aws_route53_record_lb_zone_id" {
  value = "${aws_route53_record.lb.zone_id}"
}

output "cert_manager_access_key" {
  value = "${aws_iam_access_key.cert_manager_credentials.id}"
}

output "cert_manager_secret_key" {
  value = "${aws_iam_access_key.cert_manager_credentials.secret}"
}
