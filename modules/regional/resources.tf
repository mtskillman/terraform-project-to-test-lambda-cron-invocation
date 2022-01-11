variable "function_role_arn" {
  type = string
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "lagRecordsCron"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "time-actual"

  attribute {
    name = "time-actual"
    type = "S"
  }

  tags = {
    owner        = "Matt_Skillman"
    expiration-date = "30/12/2022"
  }
}


resource "aws_lambda_function" "test_lambda" {
  filename      = "payload.zip"
  function_name = "record_cron_delay_function"
  role          = var.function_role_arn
  handler       = "main.handler"

  runtime = "python3.9"

  environment {
    variables = {
      ddb_table_name = aws_dynamodb_table.basic-dynamodb-table.name
    }
  }
}

resource "aws_lambda_alias" "test_lambda_alias" {
  name             = "my_alias"
  function_name    = aws_lambda_function.test_lambda.arn
  function_version = "1"
}

resource "aws_lambda_provisioned_concurrency_config" "example" {
  function_name                     = aws_lambda_function.test_lambda.arn
  provisioned_concurrent_executions = 2
  qualifier                         = aws_lambda_alias.test_lambda_alias.function_version
}
