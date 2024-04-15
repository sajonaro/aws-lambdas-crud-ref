locals {
  domain_name = "example.com" 
  subdomain   = "crud-http"
}


module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 3.0"

  domain_name               = local.domain_name
  zone_id                   = "Z2ES7B9AZ6SHAE"
}


module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = "dev-http"
  description   = "My awesome HTTP API Gateway"
  protocol_type = "HTTP"

  fail_on_warnings = false

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  domain_name                 = local.domain_name
  domain_name_certificate_arn = module.acm.acm_certificate_arn

  # Routes and integrations
  integrations = {
    "POST /product" = {
      lambda_arn             = aws_lambda_function.crud_lambda.invoke_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }

    "GET /product" = {
      lambda_arn             = aws_lambda_function.crud_lambda.invoke_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }

    "GET /products" = {
      lambda_arn             = aws_lambda_function.crud_lambda.invoke_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }


    "$default" = {
      lambda_arn = aws_lambda_function.crud_lambda.invoke_arn
    }
  }


  tags = {
    Name = "http-apigateway"
  }
}