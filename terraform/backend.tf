terraform {
  backend "s3" {
    bucket         = "ecs-project-tfstate-bucket"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }

}

