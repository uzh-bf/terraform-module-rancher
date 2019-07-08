resource "aws_iam_user" "cert_manager" {
  count = "${var.setup_certmgr ? 1 : 0}"

  name = "${var.certmgr_username}"
}

resource "aws_iam_access_key" "cert_manager_credentials" {
  count = "${var.setup_certmgr ? 1 : 0}"

  user = "${element(aws_iam_user.cert_manager.name, count.index)}"
}

# TODO: scoping to specific hosted zones?
resource "aws_iam_policy" "cert_manager_policy" {
  count = "${var.setup_certmgr ? 1 : 0}"

  name        = "cert_manager_dns_access"
  description = "Allow cert-manager to set TXT records for domains."

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "route53:GetChange",
      "Resource": "arn:aws:route53:::change/*"
    },
    {
      "Effect": "Allow",
      "Action": "route53:ChangeResourceRecordSets",
      "Resource": "arn:aws:route53:::hostedzone/*"
    },
    {
      "Effect": "Allow",
      "Action": "route53:ListHostedZonesByName",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "cert_manager_policy_attachment" {
  count = "${var.setup_certmgr ? 1 : 0}"

  name = "cert_manager_policy_attachment"
  policy_arn = "${aws_iam_policy.cert_manager_policy.arn}"
  users = ["${element(aws_iam_user.cert_manager.name, count.index)}"]
}
