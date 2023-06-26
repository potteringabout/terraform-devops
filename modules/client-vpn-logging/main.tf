resource "aws_cloudwatch_log_group" "client_vpns" {
  name              = "${var.name_prefix}-client-vpns"
  kms_key_id        = aws_kms_key.client_vpns_log_group.arn
  retention_in_days = var.days_to_keep_logs
  tags = {
    Name = "${var.name_prefix}-client-vpns"
  }
}

resource "aws_kms_key" "client_vpns_log_group" {
  description         = "Key used to encrypt the ${var.name_prefix}-client-vpns CloudWatch log group"
  key_usage           = "ENCRYPT_DECRYPT"
  enable_key_rotation = true
  policy = jsonencode({
    Id      = "${var.name_prefix}-client-vpns-key-policy"
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AllowIAMPermissions"
        Action = [
          "kms:*",
        ]
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Resource = "*"
      },
      {
        Sid = "AllowCloudwatch"
        Action = [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*"
        ]
        Effect = "Allow"
        Principal = {
          Service = "logs.${data.aws_region.current.name}.amazonaws.com"
        }
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "client_vpns_log_group" {
  name          = "alias/cloudwatch-logs/${aws_cloudwatch_log_group.client_vpns.name}"
  target_key_id = aws_kms_key.client_vpns_log_group.key_id
}
