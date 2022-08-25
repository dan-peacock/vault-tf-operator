output "role" {
 value = data.terraform_remote_state.aws_creds.outputs.role
}
