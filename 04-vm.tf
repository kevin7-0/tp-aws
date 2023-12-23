#Enregistrement de votre clé SSH pour la connexion au serveur
resource "aws_key_pair" "cle_ssh" {
  key_name   = "cle_ssh"
  public_key = file("~/.ssh/id_rsa.pub") # Remplacez par le chemin de votre clé publique
}

# Création d'une instance EC2
resource "aws_instance" "instance_tp_aws" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.cle_ssh.key_name
  subnet_id     = aws_subnet.sous_reseau_tp_aws.id
  vpc_security_group_ids = [aws_security_group.access_ssh.id]

  tags = {
    Name = "instance-ec2-tp-aws"
  }
}

#Affichage de L'Ip publique de la machine
output "public_ip" {
  value = aws_instance.instance_tp_aws.public_ip
}