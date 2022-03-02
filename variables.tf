variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-033b95fb8079dc481"
    us-east-2 = "ami-0b614a5d911900a9b"
    us-west-1 = "ami-0573b70afecda915d"
    us-west-2 = "ami-0341aeea105412b57"
  }
}
