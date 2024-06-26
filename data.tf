data "aws_vpc" "main" {
  tags = {
    Name = local.vpc_name
  }
}

data "aws_subnets" "private_subnet_ids" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  filter {
    name   = "tag:Scope"
    values = ["private"]
  }

  depends_on = [data.aws_vpc.main]
}


data "aws_subnet" "private_selected" {
  for_each = toset(data.aws_subnets.private_subnet_ids.ids)
  id       = each.value

  depends_on = [data.aws_subnets.private_subnet_ids]
}

data "aws_subnets" "database_subnet_ids" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  filter {
    name   = "tag:Scope"
    values = ["database"]
  }

  depends_on = [data.aws_vpc.main]
}


data "aws_subnet" "database_selected" {
  for_each = toset(data.aws_subnets.database_subnet_ids.ids)
  id       = each.value

  depends_on = [data.aws_subnets.database_subnet_ids]
}

data "aws_sns_topic" "time_tracking_event_topic" {
  name = local.subscription.through_queue.name
}

data "aws_sqs_queue" "time_sheet_notification_queue" {
  name = local.sqs.time_sheet_notification.name
}


data "aws_ecs_cluster" "cluster" {
  cluster_name = local.ecs.cluster_name
}

data "aws_security_group" "vpc_endpoint_sm_cl" {
  name = "vpc-endpoints-secretsmanager-cloudwatchlogs-sg"
}

data "aws_apigatewayv2_api" "tech_challenge_api" {
  api_id = var.api_gateway_id
}

data "aws_apigatewayv2_vpc_link" "gateway_vpc_link" {
  vpc_link_id = var.vpc_link_id
}

data "aws_lambda_function" "lambda_timesheet_receiver" {
  function_name = "hackathon-timesheet-receiver"
}