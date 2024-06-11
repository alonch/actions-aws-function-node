output "url" {
  value = length(aws_lambda_function_url.public_url) > 0? aws_lambda_function_url.public_url[0].function_url : ""
}

output "arn" {
    value = aws_lambda_function.this.arn
}