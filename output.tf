output "temp_user" {
 value = data.vault_aws_access_credentials.aws_creds.access_key
}
