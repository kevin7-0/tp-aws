terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configuration du provider AWS
provider "aws" {
  region     = "eu-west-3"
}

# Configuration du backend qui va stocker le tfstate dans une bucket nommée "buckettpaws" sous le nom tp-aws/terraform_state
#Les noms ne sont pas variabilisés car pas autorisé dans le fichier provider.
terraform {
  backend "s3" {
    bucket = "buckettpaws"
    key    = "tp-aws/terraform_state"
    region = "eu-west-3"
  }
}