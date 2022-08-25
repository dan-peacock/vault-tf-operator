data "terraform_remote_state" "vault_details" {
  backend = "remote"
  config = {
    organization = "danpeacock"
    workspaces = {
      name = "Hargreaves-Lansdown-Vault-Admin"
    }
  }
}

data "vault_aws_access_credentials" "aws_creds" {
  backend = data.terraform_remote_state.vault_details.outputs.backend
  role    = data.terraform_remote_state.vault_details.outputs.role
}

provider "aws" {
  region     = var.region
  access_key = data.vault_aws_access_credentials.aws_creds.access_key
  secret_key = data.vault_aws_access_credentials.aws_creds.secret_key
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Create AWS EC2 Instance
resource "aws_instance" "main" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.nano"
}
