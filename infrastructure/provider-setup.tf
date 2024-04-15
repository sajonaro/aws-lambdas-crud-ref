terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.30.0"
    }

  }
}

provider "aws" {
  region              = var.region
  access_key          = var.access_key
  secret_key          = var.secret_key
  allowed_account_ids = ["000000000000"]

  #todo: replace with a more secure method
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = false

  #localstack settings
  endpoints {
    sts        = "http://localstack:4566"
    cloudwatch = "http://localstack:4566"
    iam        = "http://localstack:4566"
    dynamodb   = "http://localhost:4566"
    apigateway = "http://localhost:4566"
    lambda     = "http://localhost:4566"
    route53    = "http://localhost:4566"
  }


  assume_role {
    role_arn = "arn:aws:iam::000000000000:root"
  }

}


