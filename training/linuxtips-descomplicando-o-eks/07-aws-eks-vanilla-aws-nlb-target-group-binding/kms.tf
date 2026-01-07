resource "aws_kms_key" "main" {
  description = var.kms_name
}

resource "aws_kms_alias" "main" {
  name          = format("alias/%s", var.kms_name)
  target_key_id = aws_kms_key.main.id
}

