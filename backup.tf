resource "aws_s3_bucket" "db_backups" {
  bucket = "personal-db-backups"
}

resource "aws_s3_bucket_lifecycle_configuration" "db_backups_lifecycle" {
  bucket = aws_s3_bucket.db_backups.id
  rule {
    status = "Enabled"
    id     = "expire_all_files"
    expiration {
      days = 14
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "db_backups" {
  bucket = aws_s3_bucket.db_backups.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "db_backups" {
  bucket                  = aws_s3_bucket.db_backups.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# user for Backups
resource "aws_iam_user" "db_backups" {
  name = "db-backup"
}

data "aws_iam_policy_document" "db_backups" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      aws_s3_bucket.db_backups.arn,
      "${aws_s3_bucket.db_backups.arn}/*",
    ]
  }
}

resource "aws_iam_user_policy" "db_backups" {
  name   = "access_db_backups_bucket"
  user   = aws_iam_user.db_backups.name
  policy = data.aws_iam_policy_document.db_backups.json
}