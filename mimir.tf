resource "minio_s3_bucket" "mimir_blocks" {
  bucket = "personal-mimir-blocks"
  acl    = "private"
}

output "minio_mimir_blocks_id" {
  value = minio_s3_bucket.mimir_blocks.id
}

output "minio_mimir_blocks_url" {
  value = minio_s3_bucket.mimir_blocks.bucket_domain_name
}

resource "minio_s3_bucket" "mimir_alertmanager" {
  bucket = "personal-mimir-alertmanager"
  acl    = "private"
}

output "minio_mimir_alertmanager_id" {
  value = minio_s3_bucket.mimir_alertmanager.id
}

output "minio_mimir_alertmanager_url" {
  value = minio_s3_bucket.mimir_alertmanager.bucket_domain_name
}

resource "minio_s3_bucket" "mimir_ruler" {
  bucket = "personal-mimir-ruler"
  acl    = "private"
}

output "minio_mimir_ruler_id" {
  value = minio_s3_bucket.mimir_ruler.id
}

output "minio_mimir_ruler_url" {
  value = minio_s3_bucket.mimir_ruler.bucket_domain_name
}

resource "minio_iam_user" "mimir" {
  name          = "mimir"
  force_destroy = true
}

resource "minio_iam_service_account" "mimir_sa" {
  target_user = minio_iam_user.mimir.name
}

output "minio_user" {
  value = minio_iam_service_account.mimir_sa.access_key
}

output "minio_password" {
  value     = minio_iam_service_account.mimir_sa.secret_key
  sensitive = true
}


data "minio_iam_policy_document" "mimir" {
  statement {
    actions = [
      "s3:*",
    ]
    resources = [
      minio_s3_bucket.mimir_blocks.arn,
      "${minio_s3_bucket.mimir_blocks.arn}/*",
      minio_s3_bucket.mimir_ruler.arn,
      "${minio_s3_bucket.mimir_ruler.arn}/*",
      minio_s3_bucket.mimir_alertmanager.arn,
      "${minio_s3_bucket.mimir_alertmanager.arn}/*",
    ]
  }
}

resource "minio_iam_policy" "mimir" {
  name   = "mimir-policy"
  policy = data.minio_iam_policy_document.mimir.json
}

resource "minio_iam_user_policy_attachment" "mimir_sa_rw" {
  user_name   = minio_iam_service_account.mimir_sa.target_user
  policy_name = minio_iam_policy.mimir.name
}