provider "aws" {
  region = "us-east-1" # Asegúrate de ajustar la región según tus preferencias
}

resource "aws_instance" "example" {
  ami           = "ami-058bd2d568351da34" # AMI de Debian 12 en la región us-east-1
  instance_type = "t2.micro"
  key_name      = "web-tf-ec2" # Sustituye por tu par de claves
  subnet_id     = "subnet-04d5de9fe1f40135b" # Sustituye por la ID de tu subred pública
  vpc_security_group_ids = ["sg-0090e4169f256dc56"] # Replace with the ID of the security group you want to attach

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install wget unzip -y
              sudo apt-get install docker.io -y
              sudo apt-get install git -y
              sudo groupadd docker
              sudo usermod -aG docker admin
              sudo newgrp docker
              sudo mkdir /sitio/
              cd /sitio/
              sudo git clone https://github.com/lauch4/test-site-tooplate.git
              sudo docker run -d --name apache-lautaro -p 80:80 -v /sitio/test-site-tooplate/codigo:/usr/local/apache2/htdocs/ httpd:2.4
              EOF

  tags = {
    Name = "web-tf-tooplate"
  }
}
