resource "aws_iam_user" "etcd_user" {
  name = "etcd-backup-2019"
}

resource "aws_iam_access_key" "etcd_credentials" {
  user = "${aws_iam_user.etcd_user.name}"
}

resource "aws_iam_policy" "etcd_policy" {
  name        = "etcd_s3_access"
  description = "Allow etcd to access the backup buckets."

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListAllMyBuckets",
        "s3:HeadBucket"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.etcd_bucket_prefix}etcd-*"
    },
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.etcd_bucket_prefix}etcd-*/*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "etcd_policy_attachment" {
  name       = "etcd_policy_attachment"
  policy_arn = "${aws_iam_policy.etcd_policy.arn}"
  users      = ["${aws_iam_user.etcd_user.name}"]
}

resource "aws_s3_bucket" "rancher_etcd_bucket" {
  bucket = "${var.etcd_bucket_prefix}etcd-rancher"
  acl    = "private"
}

resource "aws_s3_bucket" "devops_etcd_bucket" {
  bucket = "${var.etcd_bucket_prefix}etcd-devops"
  acl    = "private"
}

resource "aws_s3_bucket" "sim_etcd_bucket" {
  bucket = "${var.etcd_bucket_prefix}etcd-sim"
  acl    = "private"
}
