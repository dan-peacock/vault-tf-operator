data "terraform_remote_state" "creds" {
  backend = "remote"

  config = {
    backend = vault_aws_secret_backend.aws.path
    role = vault_aws_secret_backend_role.admin.name
    organization = "org-K9XgZ2feWb8hQMZE"
    workspaces = {
      name = "Hargreaves-Lansdown-Vault-Admin"
    }
  }
}

# provider "aws" {
#   region     = var.region
#   access_key = data.creds.outputs.vault_aws_access_credentials.creds.access_key
#   secret_key = data.creds.outputs.vault_aws_access_credentials.creds.secret_key
# }

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }

# # Create AWS EC2 Instance
# resource "aws_instance" "main" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t2.nano"

#   tags = {
#     Name  = var.name
#     TTL   = var.ttl
#     owner = "${var.name}-guide"
#   }
# }
