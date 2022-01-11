variable "function_role_arn" {
  type = string
}

variable "tags_to_use" {
  type = map(string)
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "lagRecordsCron"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "time-actual"

  attribute {
    name = "time-actual"
    type = "S"
  }

  tags = var.tags_to_use
}


resource "aws_lambda_function" "test_lambda" {
  filename      = "payload.zip"
  function_name = "record_cron_delay_function"
  role          = var.function_role_arn
  handler       = "main.handler"
  publish = true
  runtime = "python3.9"

  environment {
    variables = {
      ddb_table_name = aws_dynamodb_table.basic-dynamodb-table.name
    }
  }
  tags = var.tags_to_use
}


resource "aws_lambda_provisioned_concurrency_config" "example" {
  function_name                     = aws_lambda_function.test_lambda.arn
  provisioned_concurrent_executions = 1
  qualifier                         = aws_lambda_function.test_lambda.version
}


resource "aws_cloudwatch_event_rule" "every_minute" {
    name = "every-minute"
    schedule_expression = "cron(0/1 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "check_foo_every_one" {
    rule = aws_cloudwatch_event_rule.every_minute.name
    target_id = "every_minute"
    arn = aws_lambda_function.test_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_check" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.test_lambda.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.every_minute.arn
}
