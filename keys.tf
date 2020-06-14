resource "aws_key_pair" "main-key" {
  key_name   = "main-key"
  public_key = var.PUBLIC_KEY
}