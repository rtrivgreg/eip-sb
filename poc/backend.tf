terraform {
  backend "s3" {
    bucket       = "rg-tf-state-dev"
    key          = "vpc-endpoints/poc/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
