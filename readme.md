# TP AWS de création d'une VM dans un VPC avec stockage du tfstate dans un bucket AWS

## Guide d'utilisation

### Prérequis :
- Avoir teraform sur son poste - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Avoir une clé ssh de généré sur son poste - https://www.aquaray.com/blog/articles/comment-generer-une-cle-SSH
- Avoir créé un bucket nommé `buckettpaws` sur son compte aws - https://docs.aws.amazon.com/fr_fr/AmazonS3/latest/userguide/creating-bucket.html
- Avoir créé une access key sur AWS - https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html
- Avoir installer la cli AWS - `sudo apt install awscli`

### Etape :
- Copier le contenu de ce repo et se positionner dans le répertoire de travail
- faire un : `aws configure` pour positionner ces identifiants aws et la région utilisée.
- lancer un `terraform init` pour initialiser terraform
- lancer un `terraform plan` pour verifier ce qu'il va faire
- lancer un `terraform apply` pour créer la VM ainsi que les autres objets néccéssaires à son fonctionnement.
- faire un `ssh ec2-user@adresse_ip` avec l'adresse IP renvoyé à la fin du apply
- faire un `terraform destroy` pour tout supprimer

# Problèmes rencontrées et solutions

### Problème pour faire fonctionner le Backend.

kevin@core:~/tp-aws$ terraform init

Initializing the backend...
╷
│ Error: No valid credential sources found
│ 
│ Please see https://www.terraform.io/docs/language/settings/backends/s3.html
│ for more information about providing credentials.
│ 
│ Error: failed to refresh cached credentials, no EC2 IMDS role found, operation error ec2imds: GetMetadata, request canceled, context deadline exceeded

- Solution - Passer par un : `sudo apt install awscli` puis `aws configure` pour spécifier mes clef d'accés.

### Probléme sur les clefs ssh :

│ Error: importing EC2 Key Pair (tp-aws-key): InvalidKey.Format: Key is not in valid OpenSSH public key format
│       status code: 400, request id: 82c03fb2-4d17-4a6e-8854-7b7d7af9fb04
│ 
│   with aws_key_pair.my_key_pair,
│   on 03-main.tf line 46, in resource "aws_key_pair" "my_key_pair":
│   46: resource "aws_key_pair" "my_key_pair" {

Solution - Après analyse de la doc il ne créee pas de clef il enregistre la cléf qu'on lui fournis,
il faut donc spécifier le chemin de sa clé SSH personnel créé précédement.

### Probléme d'accés en SSH à la machine via mon environnement de dev ou via l’interface aws.

Failed to connect to your instance
EC2 Instance Connect is unable to connect to your instance. Ensure your instance network settings are configured correctly for EC2 Instance Connect. For more information, see EC2 Instance Connect Prerequisites at https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-connect-prerequisites.html.

Solution - Il faut créer une table de routage et une passerelle internet pour que ça fonctionne.
