terraform {
  backend "s3" {
    bucket = "chibuzor-cloudformation-templates"
    key    = "vpc.tfstate"
    region = "us-east-1"
    dynamodb_table = "jjtfstate"
  }
}