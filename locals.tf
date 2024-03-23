locals {
  default_region = "us-east-1"
  project_name   = "timesheet-service"
  context_name   = "Timesheet"

  vpc_name = "tc-vpc"

  s3 = {
    bucket_name = "time-sheet"
  }
}