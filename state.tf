variable "state_bucket_name" {}
variable "state_lock_table_name" {}

resource "aws_s3_bucket" "sample_terraform_state" {
  bucket = var.state_bucket_name
  force_destroy = true
  versioning {
    enabled = true
  }
  provisioner "local-exec" {
    when = destroy
    command = "aws s3api delete-objects --bucket ${self.bucket} --delete \"$(aws s3api list-object-versions --bucket ${self.bucket} --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')\""
  }
}

resource "aws_dynamodb_table" "sample_terraform_state_lock" {
  name           = var.state_lock_table_name
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}