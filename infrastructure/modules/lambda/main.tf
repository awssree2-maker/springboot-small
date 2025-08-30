data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambdafunction"
  output_path = "${path.module}/lambdafunction.zip"
}


resource "aws_lambda_function" "my_csv_to_parquet" {
  function_name = "csv-to-parquet-lambda"
  role          = aws_iam_role.my_lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256


  timeout = 60
  memory_size = 512
  layers = [
    "arn:aws:lambda:ap-south-1:734842485697:layer:AWSSDKPandas-Python39:25"
  ]
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "spring-sfserdff-bucket"

  lambda_function {
    lambda_function_arn = aws_lambda_function.my_csv_to_parquet.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "input/"
    filter_suffix       = ".csv"
  }

  depends_on = [aws_lambda_permission.my_allow_s3]
}

resource "aws_lambda_permission" "my_allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_csv_to_parquet.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::spring-sfserdff-bucket"
}
