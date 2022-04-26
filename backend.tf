terraform {
    backend "s3" {
    bucket = "bucket-state-prueba"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true


    }


}
