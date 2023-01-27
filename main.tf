# Provider Block
provider "aws" {
  # profile = "sb" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "us-east-1"
}

module "visitor_count_table" {
  source = "./modules/dynamodb"

}

module "iam_for_lambda" {
  source = "./modules/iam_role"

}

module "lambda_counter" {
  source = "./modules/lambda_function"

  file_name     = "lambda_function.zip"
  function_name = "get_counter_dynamo"
  role          = module.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  type        = "zip"
  source_file = "./lambda_function.py"
  output_path = "./lambda_function.zip"

}


module "api_gateway" {
  source = "./modules/api_gateway"

  integration_uri           = module.lambda_counter.invoke_arn
  permissions_function_name = module.lambda_counter.function_name

}






resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.www_bucket.id

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.www_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }

}

resource "aws_s3_bucket_website_configuration" "root_bucket" {
  bucket = aws_s3_bucket.root_bucket.bucket

  redirect_all_requests_to {
    host_name = "www.test.kenbrake.com"
  }

}

resource "aws_s3_bucket_acl" "example_bucket_acl" {
  bucket = aws_s3_bucket.www_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_acl" "root_bucket_acl" {
  bucket = aws_s3_bucket.root_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.www_bucket.id
  policy = templatefile("templates/s3-policy.json", { bucket = "www.${var.bucket_name}" })
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account2" {
  bucket = aws_s3_bucket.root_bucket.id
  policy = templatefile("templates/s3-policy.json", { bucket = var.bucket_name })
}

# S3 bucket for website.
resource "aws_s3_bucket" "www_bucket" {
  bucket = "www.${var.bucket_name}"

  tags = var.common_tags

  force_destroy = true
}

# S3 bucket for redirecting non-www to www.
resource "aws_s3_bucket" "root_bucket" {
  bucket = var.bucket_name

  tags = var.common_tags

  force_destroy = true
}