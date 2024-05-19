resource "aws_lambda_function" "php-lambda" {
  function_name    = "php-app"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index"
  image_uri        =  var.image_url
  package_type     =  "Image"

}

resource "aws_iam_role" "lambda_role" {
  name     = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}