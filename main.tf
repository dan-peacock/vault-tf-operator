data "terraform_remote_state" "vault_details" {
  backend = "remote"
  config = {
    organization = "danpeacock"
    workspaces = {
      name = "Hargreaves-Lansdown-Admin"
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


# Create AWS EC2 Instance
resource "aws_instance" "main" {
  ami           = "ami-0e34bbddc66def5ac"
  instance_type = "t2.nano"
}
