resource "aws_key_pair" "bastion" {
  key_name = "bastion_key_${var.environment}"
  public_key = ""
}

resource "aws_key_pair" "app" {
  key_name = "instance_key_${var.environment}"
  public_key = ""
}