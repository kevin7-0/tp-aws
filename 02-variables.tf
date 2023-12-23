# Dans ce fichier nous définissons toutes les variables qui peuvent servir au projet.

variable "aws_region" {
  description = "La région AWS dans laquelle déployer l'infrastructure."
  default     = "eu-west-3"
}

variable "vpc_cidr" {
  description = "CIDR du VPC."
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR du sous-réseau."
  default     = "10.0.1.0/24"
}

variable "cidr_blocks" {
  description = "CIDR blocks autorisés pour SSH."
  default     = ["0.0.0.0/0"] # Inséré ici votre adresse IP pour pouvoir vous connecter en SSH aux machines ou laisser 0.0.0.0/0 pour un accés depuis n'importe quel machine
}

variable "public_key" {
  description = "Clé publique SSH."
  default     = "~/.ssh/id_rsa.pub" # Chemin vers votre clef publique personnel présentes sur votre machine/serveur.
}

variable "ami_id" {
  description = "ID AMI pour l'instance EC2."
  default     = "ami-02ea01341a2884771" # Id de l'AMI utilisé pour créer l'instance EC2
}

variable "instance_type" {
  description = "Type d'instance EC2."
  default     = "t2.micro" # Type de l'instance que l'on va créer via les scripts
}
