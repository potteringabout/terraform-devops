resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


variable "rep_rules" {
  type    = list(string)
  default = [
    {
      "id": "tab1",
      "path": "/baba"
    },
    {
      "id": "tab2",
      "path": "/xxx"
    }
  ]
}



resource "aws_s3_bucket_replication_configuration" "replication" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.source]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.source.id

  dynamic "rule" {

    for_each = var.rep_rules
    content {
      id = setting.value["id"]

      filter {
        prefix = setting.value["path"]
      }
      status = "Enabled"

      destination {
        bucket        = aws_s3_bucket.destination.arn
        storage_class = "STANDARD"
      }
    }  

  }

}
