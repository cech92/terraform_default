terraform {
    backend "s3" {
        bucket = "myterraformstates"
        key = "terraform/web"
        region = "eu-west-1"
    }
}