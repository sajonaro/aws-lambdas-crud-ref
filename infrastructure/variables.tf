variable "region" {
  default = "us-east-1"

}

variable "app_name" {

}

variable "tag" {

}


variable "secret_key" {
  #localstack
  default = "12345"
}

variable "access_key" {
  #localstack
  default = "000000000000"
}

variable "environment" {
  default = "dev"

}

variable "dynamodb_table_name" {
  default = "product"

}

variable "api_name" {
  default = "product-api"

}

variable "root_path" {
  default = "product"

}

variable "function_name" {
  default = "crud_lambda"

}