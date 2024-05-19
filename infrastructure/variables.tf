variable "region" {
  default = "us-east-1"

}

variable "app_name" {
  default = "php-app"
}

variable "tag" {
  default = "1.0.0"

}

variable "image_url" {
 
  
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
  default = "php_lambda"

}