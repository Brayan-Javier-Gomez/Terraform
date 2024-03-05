provider "aws" {
  region = "us-east-1"
}
variable "content" {
  type = string
  default = "<h1>Hola desde terraform</h1>"
}

resource "aws_s3_bucket" "buckets3" {
  bucket = "bucketname" #Nombre del bucket a generar
  
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

/* Codigo de configuracion politica acl
resource "aws_s3_bucket_acl" "acl-policy" {
  bucket = aws_s3_bucket.buckets3.id
  acl    = "public-read"
}
*/
resource "aws_s3_bucket_website_configuration" "web-s3-configuration" {
  bucket = aws_s3_bucket.buckets3.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "object" {
  bucket       = aws_s3_bucket.buckets3.bucket
  key          = "index.html"
  content      = var.content
  content_type = "text/html"
}
