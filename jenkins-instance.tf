# data "aws_ami" "ubuntu_jenkins" {
#   most_recent = true
#   owners      = ["099720109477"]

#   filter {
#     name   = "name"
#     values = ["${var.image_name}"]
#   }
#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }


resource "aws_instance" "jenkins" {
  ami                    = "ami-007855ac798b5175e"
  instance_type          = "t2.micro"
  availability_zone      = "ap-south-1"
  key_name               = aws_key_pair.jen-kp.key_name
  vpc_security_group_ids = [aws_security_group.default-sg.id]


  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt install openjdk-11-jre -y",
      "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install jenkins -y",
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/jen-ansi")
    host        = self.public_ip
  }

  tags = {
    Name = "Jenkins-server"
  }
}
