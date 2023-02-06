# Provider Block
provider "aws" {
  #profile = "sb" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region = var.region
}

module "visitor_count_table" {
  source = "./modules/dynamodb"

  table_name = "visitor-counter"

}

module "iam_for_lambda" {
  source = "./modules/iam_role"

  dynamodb_arn = module.visitor_count_table.arn

}

module "lambda_counter" {
  source = "./modules/lambda_function"

  file_name     = "lambda_function.zip"
  function_name = "get_counter_dynamo"
  role          = module.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  type        = "zip"
  source_dir  = "./app"
  output_path = "./lambda_function.zip"

}

module "api_gateway" {
  source = "./modules/api_gateway"

  integration_uri           = module.lambda_counter.invoke_arn
  permissions_function_name = module.lambda_counter.function_name

}



resource "aws_route53_zone" "api_zone" {
  name = "api.test.kenbrake.com"
}
