variable "target" {
  description = "OU resource to attach SCP"
  type = object({
    name = string
    id   = string
  })
}

variable "deny_all" {
  description = "If false, create a combined policy. If true, deny all access"
  default     = false
  type        = bool
}

# Policy Statement Switches

variable "deny_leaving_orgs" {
  description = "DenyLeavingOrgs in the OU policy."
  default     = false
  type        = bool
}

variable "deny_creating_iam_users" {
  description = "DenyCreatingIAMUsers in the OU policy."
  default     = false
  type        = bool
}

variable "deny_creating_iam_only_users" {
  description = "DenyCreatingIAMUsers Only in the OU policy."
  default     = false
  type        = bool
}

variable "deny_deleting_kms_keys" {
  description = "DenyDeletingKMSKeys in the OU policy."
  default     = false
  type        = bool
}

variable "deny_deleting_route53_zones" {
  description = "DenyDeletingRoute53Zones in the OU policy."
  default     = false
  type        = bool
}

variable "deny_deleting_cloudwatch_logs" {
  description = "DenyDeletingCloudwatchLogs in the OU policy."
  default     = false
  type        = bool
}

variable "deny_root_account" {
  description = "DenyRootAccount in the OU policy."
  default     = false
  type        = bool
}

variable "protect_s3_buckets" {
  description = "ProtectS3Buckets in the OU policy."
  default     = false
  type        = bool
}

variable "deny_s3_buckets_public_access" {
  description = "DenyS3BucketsPublicAccess in the OU policy."
  default     = false
  type        = bool
}

variable "protect_iam_roles" {
  description = "ProtectIAMRoles in the OU policy."
  default     = false
  type        = bool
}

variable "limit_ec2_instance_types" {
  description = "LimitEC2InstanceTypes in the OU policy."
  default     = false
  type        = bool
}

variable "limit_regions" {
  description = "LimitRegions in the OU policy."
  default     = false
  type        = bool
}

variable "require_s3_encryption" {
  description = "DenyIncorrectEncryptionHeader and DenyUnEncryptedObjectUploads in the OU policy"
  default     = false
  type        = bool
}

# Policy-specific resources

variable "protect_s3_bucket_resources" {
  description = "S3 bucket resource ARNs to protect from bucket and object deletion"
  type        = list(string)
  default     = [""]
}

variable "deny_s3_bucket_public_access_resources" {
  description = "S3 bucket resource ARNs to block public access"
  type        = list(string)
  default     = [""]
}

variable "protect_iam_role_resources" {
  description = "IAM role resource ARNs to protect from modification and deletion"
  type        = list(string)
  default     = [""]
}

variable "allowed_regions" {
  description = "AWS Regions allowed for use (for use with the restrict regions SCP)"
  type        = list(string)
  default     = [""]
}

variable "allowed_ec2_instance_types" {
  description = "EC2 instances types allowed for use"
  type        = list(string)
  default     = [""]
}

variable "tags" {
  description = "Tags applied to the SCP policy"
  type        = map(string)
  default     = {}
}
