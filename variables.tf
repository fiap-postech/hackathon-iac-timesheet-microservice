variable "app_database_password" {
  type        = string
  description = "password that tech-challenge service will use to connect to database"
}

variable "api_gateway_id" {
  type        = string
  description = "api gateway id where we should create microservices endpoints"
}

variable "vpc_link_id" {
  type        = string
  description = "vpc link id to be used in api gateway configuration"
}

variable "authorizer_id" {
  type        = string
  description = "API Gateway Authorizer ID"
}

variable "aes_algorithm" {
  type        = string
  description = "Algorithm to be used in customer data removal encryption flow"
}

variable "aes_password" {
  type        = string
  description = "AES Password to be used in customer data removal encryption flow"
}

variable "aes_iv" {
  type        = string
  description = "AES IV to be used in customer data removal encryption flow"
}

