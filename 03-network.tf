# Création du VPC qui va heberger la machine.
resource "aws_vpc" "vpc_tp_aws" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc_tp_aws"
  }
}

# Création d'un sous-réseau dans le VPC
resource "aws_subnet" "sous_reseau_tp_aws" {
  vpc_id                  = aws_vpc.vpc_tp_aws.id
  cidr_block             = var.subnet_cidr 
  map_public_ip_on_launch = true
  tags = {
    Name = "sous_reseau_tp_aws"
  }
}

# Création de la passerelle Internet
resource "aws_internet_gateway" "gateway_tp_aws" {
  vpc_id = aws_vpc.vpc_tp_aws.id

  tags = {
    Name = "gateway_tp_aws"
  }
}

# Création d'une table de routage pour que le VPC accède à internet.
resource "aws_route_table" "route_tp_aws" {
  vpc_id = aws_vpc.vpc_tp_aws.id

  route {
    cidr_block = "0.0.0.0/0" # Il ne veut pas d'une variable ici
    gateway_id = aws_internet_gateway.gateway_tp_aws.id
  }

  tags = {
    Name = "route_tp_aws"
  }
}

# Association de la table de routage au sous-réseau
resource "aws_route_table_association" "association_tp_aws" {
  subnet_id      = aws_subnet.sous_reseau_tp_aws.id
  route_table_id = aws_route_table.route_tp_aws.id
}

# Création d'un groupe de sécurité autorisant SSH depuis n'importe quelle adresse IP
resource "aws_security_group" "access_ssh" {
  vpc_id = aws_vpc.vpc_tp_aws.id
  name        = "acces_ssh"
  description = "Autorise la connexion SSH depuis le block indique"

  # Création de la régle entrante autorisant la connexion SSH.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Création de la régle sortante autorisant tout le trafic sortant.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Les CIDR Block ne sont pas variabilisé dans les régles de filtrage pour simplifier les tests en cas de besoin de modification de plage.