resource "aws_lambda_function" "post" {
  function_name = "${var.function_name_prefix}-post"
  role = aws_iam_role.lambda_role.arn
  runtime = "python3.8"
  handler = "main.post_request"
  timeout = 30

  filename = "../code.zip"
  source_code_hash = filebase64sha256("../code.zip")

  layers = [ aws_lambda_layer_version.lsaas.arn ]

  environment {
    variables = {
      CLOUDFLARE_TOKEN = var.cloudflare_token_lambda
      CLOUDFLARE_ZONE_ID = var.cloudflare_zone_id
    }
  }
}

resource "aws_lambda_function" "get_result" {
  function_name = "${var.function_name_prefix}-getResult"
  role = aws_iam_role.lambda_role.arn
  runtime = "python3.8"
  handler = "main.get_result"
  timeout = 30

  filename = "../code.zip"
  source_code_hash = filebase64sha256("../code.zip")

  layers = [ aws_lambda_layer_version.lsaas.arn ]
}