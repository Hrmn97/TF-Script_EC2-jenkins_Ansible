# data "aws_ami" "ubuntu_ansible" {
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


resource "aws_instance" "ansible" {
  ami                    = "ami-007855ac798b5175e"
  instance_type          = "t2.micro"
  availability_zone      = "ap-south-1"
  key_name               = aws_key_pair.jen-kp.key_name
  vpc_security_group_ids = [aws_security_group.default-sg.id]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt install software-properties-common -y",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible -y",
      "sudo apt install ansible -y",
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/jen-ansi")
    host        = self.public_ip
  }

  tags = {
    Name = "Ansible-server"
  }


}
