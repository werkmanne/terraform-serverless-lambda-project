# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "bello-terraform-state-files-new"
    key            = "terraform-serverless-lambda-project/terraform.tfstate"
    region         = "us-east-1"
    profile        = "bello-terraform-user"
    dynamodb_table = "terraform-state-lock-serverless-lambda"
  }
}