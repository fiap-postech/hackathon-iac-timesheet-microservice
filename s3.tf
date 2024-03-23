resource "aws_s3_bucket" "customer_data_removal_bucket" {
  bucket        = local.s3.bucket_name
  force_destroy = true

  tags = {
    Name = local.s3.bucket_name
  }
}

resource "aws_s3_bucket_versioning" "customer_data_removal_versioning" {
  bucket = aws_s3_bucket.customer_data_removal_bucket.id

  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [aws_s3_bucket.customer_data_removal_bucket]
}

resource "aws_s3_bucket_ownership_controls" "customer_data_removal_ownership_controls" {
  bucket = aws_s3_bucket.customer_data_removal_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }

  depends_on = [aws_s3_bucket.customer_data_removal_bucket]
}

resource "aws_s3_bucket_public_access_block" "customer_data_removal_public_access_block" {
  bucket = aws_s3_bucket.customer_data_removal_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true

  depends_on = [aws_s3_bucket.customer_data_removal_bucket]
}

resource "aws_s3_bucket_acl" "customer_data_removal_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.customer_data_removal_ownership_controls,
    aws_s3_bucket_public_access_block.customer_data_removal_public_access_block,
  ]

  bucket = aws_s3_bucket.customer_data_removal_bucket.id
  acl    = "private"
}