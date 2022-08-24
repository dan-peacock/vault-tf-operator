output "backend" {
 value = data.terraform_remote_state.creds.vault_aws_secret_backend.aws.path
}
output "role" {
 value = data.terraform_remote_state.creds.outputs.role
}