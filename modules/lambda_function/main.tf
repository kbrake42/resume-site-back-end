resource "aws_lambda_function" "function" {

  filename      = var.file_name
  function_name = var.function_name
  role          = var.role
  handler       = var.handler
  runtime       = var.runtime

  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

}

data "archive_file" "lambda_zip" {
  type        = var.type
  source_dir  = var.source_dir
  output_path = var.output_path
}
