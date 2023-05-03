resource "aws_key_pair" "jen-kp" {
  key_name   = "jenkins-key"
  public_key = file("${path.module}/jen-ansi.pub")
}
