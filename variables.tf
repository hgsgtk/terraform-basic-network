variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "key_name" {
  description = "the name of aws key pair"
}

variable "public_key_path" {
  description = "path to the ssh public key"
}
