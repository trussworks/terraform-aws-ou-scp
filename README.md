## AWS OU SCP Terraform Module

Supports two main use cases:

* Combines multiple Service Control Policies (SCP) statements based on the policies defined in [`terraform-aws-org-scp`](https://github.com/trussworks/terraform-aws-org-scp). Creating a single policy allows more than 5 policies to be be applied to a single Organizational Unit (OU).
* Alternatively, creates a "Deny All Access" Service Control Policy.

The following statements are included in the combined policy (listed by `sid`), with Deny/Allow toggled for each:

* Deny root account (DenyRootAccount)
* Deny leaving AWS Organizations (DenyLeavingOrgs)
* Deny creating IAM users or access keys (DenyCreatingIAMUsers)
* Deny deleting KMS Keys (DenyDeletingKMSKeys)
* Deny deleting Route53 Hosted Zones (DenyDeletingRoute53Zones)
* Require S3 encryption (DenyIncorrectEncryptionHeader + DenyUnEncryptedObjectUploads)
* Deny deleting VPC Flow logs, Cloudwatch log groups, and Cloudwatch log streams (DenyDeletingCloudwatchLogs)
* Protect S3 Buckets (ProtectS3Buckets)
* Protect IAM Roles (ProtectIAMRoles)
* Restrict Regional Operations (LimitRegions)

## Terraform Versions

_This is how we're managing the different versions._
Terraform 0.12. Pin module version to ~> 2.0. Submit pull-requests to master branch.

Terraform 0.11. Pin module version to ~> 1.0. Submit pull-requests to terraform011 branch.

### Usage for combined policy statements

```hcl
// TODO: make sure these references to module names are correct once pushed to the registry
module "ou_scp" {
  source = "trussworks/ou-scp"
  target = {
    name = "my_ou"
    id = aws_organizations_organizational_unit.my_ou.id
  }

  # true means the policy is in effect

  deny_root_account = true
  deny_leaving_orgs = true
  deny_creating_iam_users = true
  deny_deleting_kms_keys = true
  deny_deleting_route53_zones = true
  require_s3_encryption = true
  deny_deleting_cloudwatch_logs = true

  limit_regions = true
  # - restrict region-specific operations to us-west-2
  allowed_regions                  = ["us-west-2"]

  protect_s3_buckets = true
  # - protect terraform statefile bucket
  protect_s3_bucket_resources = [
    "arn:aws:s3:::prod-terraform-state-us-west-2",
    "arn:aws:s3:::prod-terraform-state-us-west-2/*"
  ]

  protect_iam_roles = true
  # - protect OrganizationAccountAccessRole
  protect_iam_role_resources = [
    "arn:aws:iam::*:role/OrganizationAccountAccessRole"
  ]
}
```

### Usage for a policy which denies all access

```hcl
module "scp_test_scp" {
  # source needs to be the most recent commit hash
  source = "trussworks/ou-scp"
  target = {
    name = "my_ou"
    id = aws_organizations_organizational_unit.my_ou.id
  }

  deny_all=true
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_regions | AWS Regions allowed for use (for use with the restrict regions SCP) | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| deny\_all | If false, create a combined policy. If true, deny all access | `bool` | `false` | no |
| deny\_creating\_iam\_users | DenyCreatingIAMUsers in the OU policy. | `bool` | `false` | no |
| deny\_deleting\_cloudwatch\_logs | DenyDeletingCloudwatchLogs in the OU policy. | `bool` | `false` | no |
| deny\_deleting\_kms\_keys | DenyDeletingKMSKeys in the OU policy. | `bool` | `false` | no |
| deny\_deleting\_route53\_zones | DenyDeletingRoute53Zones in the OU policy. | `bool` | `false` | no |
| deny\_leaving\_orgs | DenyLeavingOrgs in the OU policy. | `bool` | `false` | no |
| deny\_root\_account | DenyRootAccount in the OU policy. | `bool` | `true` | no |
| limit\_regions | LimitRegions in the OU policy. | `bool` | `false` | no |
| protect\_iam\_role\_resources | IAM role resource ARNs to protect from modification and deletion | `list(string)` | `[]` | no |
| protect\_iam\_roles | ProtectIAMRoles in the OU policy. | `bool` | `false` | no |
| protect\_s3\_bucket\_resources | S3 bucket resource ARNs to protect from bucket and object deletion | `list(string)` | `[]` | no |
| protect\_s3\_buckets | ProtectS3Buckets in the OU policy. | `bool` | `false` | no |
| require\_s3\_encryption | RequireS3Encryption in the OU policy. | `bool` | `false` | no |
| target | OU resource to attach SCP | <pre>object({<br>    name = string<br>    id   = string<br>  })</pre> | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Developer Setup

Install dependencies (macOS)

```shell
brew install pre-commit go terraform terraform-docs
pre-commit install --install-hooks
```
