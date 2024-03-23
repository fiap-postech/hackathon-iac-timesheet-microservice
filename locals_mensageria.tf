locals {
  subscription = {
    through_queue = {
      name                 = "prd-time-tracking-event-topic"
      protocol             = "sqs"
      raw_message_delivery = true
    }
  }

  sqs = {
    delay_seconds              = 0
    max_message_size           = 262144
    message_retention_seconds  = 86400
    receive_wait_time_seconds  = 0
    visibility_timeout_seconds = 60
    sqs_managed_sse_enabled    = true
    time_tracking_event = {
      name = "prd-hackathon-time-sheet-time-tracking-event-queue"
    }
    time_sheet_request = {
      name = "local-hackathon-time-sheet-request-queue"
    }
  }
}