resource "aws_s3_bucket" "mimir_blocks" {
  bucket = "personal-mimir-blocks"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mimir_blocks" {
  bucket = aws_s3_bucket.mimir_blocks.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "mimir_blocks" {
  bucket                  = aws_s3_bucket.mimir_blocks.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ---------

resource "aws_s3_bucket" "mimir_alertmanager" {
  bucket = "personal-mimir-alertmanager"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mimir_alertmanager" {
  bucket = aws_s3_bucket.mimir_alertmanager.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "mimir_alertmanager" {
  bucket                  = aws_s3_bucket.mimir_alertmanager.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ---------

resource "aws_s3_bucket" "mimir_ruler" {
  bucket = "personal-mimir-ruler"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mimir_ruler" {
  bucket = aws_s3_bucket.mimir_ruler.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "mimir_ruler" {
  bucket                  = aws_s3_bucket.mimir_ruler.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# user for Grafana Mimir used to access S3 bucket
resource "aws_iam_user" "mimir" {
  name = "mimir-s3"
}

data "aws_iam_policy_document" "mimir" {
  statement {
    effect  = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      aws_s3_bucket.mimir_blocks.arn,
      "${aws_s3_bucket.mimir_blocks.arn}/*",
      aws_s3_bucket.mimir_alertmanager.arn,
      "${aws_s3_bucket.mimir_alertmanager.arn}/*",
      aws_s3_bucket.mimir_ruler.arn,
      "${aws_s3_bucket.mimir_ruler.arn}/*",
    ]
  }
}

resource "aws_iam_access_key" "mimir" {
  user    = aws_iam_user.mimir.name
  pgp_key = "keybase:tomaskozak"
}

output "mimir_key" {
  value = aws_iam_access_key.mimir.id
}

output "mimir_encrypted_secret" {
  value = aws_iam_access_key.mimir.encrypted_secret
}

resource "aws_iam_user_policy" "mimir" {
  name   = "access_mimir_s3_bucket"
  user   = aws_iam_user.mimir.name
  policy = data.aws_iam_policy_document.mimir.json
}
