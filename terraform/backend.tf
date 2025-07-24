# Remote backend configuration for Terraform state management
terraform {
  backend "s3" {
    bucket       = "ecs-project-tfstate-bucket"
    key          = "terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
    encrypt      = true
  }

}

