# Outputs placeholder
output "scp_policy_json" {
  value = data.aws_iam_policy_document.combined_policy_block.json
}