
resource "aws_apigatewayv2_integration" "timesheet_receiver_integration" {
  api_id = data.aws_apigatewayv2_api.tech_challenge_api.id

  integration_uri  = data.aws_lambda_function.lambda_timesheet_receiver.invoke_arn
  integration_type = "AWS_PROXY"

  request_parameters = {
    "overwrite:header.x-employee-id"    = "$context.authorizer.employeeId"
    "overwrite:header.x-employee-email" = "$context.authorizer.employeeEmail"
  }

  depends_on = [data.aws_lambda_function.lambda_timesheet_receiver]
}

resource "aws_apigatewayv2_route" "timeshet_receiver_route" {
  api_id    = data.aws_apigatewayv2_api.tech_challenge_api.id
  route_key = "POST /timesheet/report"
  target    = "integrations/${aws_apigatewayv2_integration.timesheet_receiver_integration.id}"

  authorization_type = "CUSTOM"
  authorizer_id      = var.authorizer_id

  depends_on = [
    aws_apigatewayv2_integration.timesheet_receiver_integration
  ]
}

resource "aws_lambda_permission" "api_gw_to_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.lambda_timesheet_receiver.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${data.aws_apigatewayv2_api.tech_challenge_api.execution_arn}/*/*"

  depends_on = [
    data.aws_lambda_function.lambda_timesheet_receiver,
    data.aws_apigatewayv2_api.tech_challenge_api
  ]
}