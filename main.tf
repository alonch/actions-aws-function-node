locals {
  services = {
    s3 = {
      read  = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
      write = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
    }
    dynamodb = {
      read  = ["arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"]
      write = ["arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"]
    }
  }

  policies = flatten(
    [
      ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"],
      [for service, access_level in var.permissions : local.services[service][access_level]]
  ])

  # input: 
  # var.entrypoint-file   = src/index.js 
  # output: 
  # local.entrypoint-file = src/index
  entrypoint-file = replace(var.entrypoint-file, "/.[^.]+$/", "")
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name                = var.name
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = local.policies
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = var.artifacts
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "this" {
  filename      = "lambda_function_payload.zip"
  function_name = var.name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "${local.entrypoint-file}.${var.entrypoint-function}"
  architectures = [var.architecture]
  memory_size   = var.memory

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = var.runtime
  timeout = var.timeout
  environment {
    variables = var.env
  }
}

resource "aws_lambda_function_url" "public_url" {
  count              = var.allow-public-access ? 1 : 0
  function_name      = aws_lambda_function.this.function_name
  authorization_type = "NONE"
}
