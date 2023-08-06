resource "aws_s3_bucket" "snapshots" {
  bucket = "datared-snapshots"
  tags = {
    Name = "datared-snapshots"
  }
}

