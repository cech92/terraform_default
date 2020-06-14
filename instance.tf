resource "aws_instance" "web" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"

  // print the private ip of the instance into "private_ips.txt" file after terraform apply
  provisioner "local-exec" {
    command = "echo ${aws_instance.web.private_ip} >> private_ips.txt"
  }
}

// print the public ip of the instance after terraform apply
output "ip" {
  value = aws_instance.web.public_ip
}
