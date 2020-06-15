variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "eu-west-1"
}
variable "PUBLIC_KEY" {}
variable "AMIS" {
    type = map(string)
    default = {
        eu-west-1 = "ami-089cc16f7f08c4457"
    }
}