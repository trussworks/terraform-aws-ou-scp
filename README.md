## AWS OU SCP Terraform Module

Supports two main use cases:

* Combines multiple Service Control Policy (SCP) statements based on the policies defined in [`terraform-aws-org-scp`](https://github.com/trussworks/terraform-aws-org-scp). Combining multiple policy statements into a single policy allows more than 5 policies to be be applied to a single Organizational Unit (OU).
* Alternatively, creates a "Deny All Access" Service Control Policy.

 Alternatively, enables creation of a "Deny All Access" Service Control Policy.

Policy options (listed by `sid`) are:

* Deny leaving AWS Organizations (DenyLeavingOrgs)
* Deny creating IAM users or access keys (DenyCreatingIAMUsers)
* Deny deleting KMS Keys (DenyDeletingKMSKeys)
* Deny deleting Route53 Hosted Zones (DenyDeletingRoute53Zones)
* Deny deleting VPC Flow logs, Cloudwatch log groups, and Cloudwatch log streams (DenyDeletingCloudwatchLogs)
* Deny root account (DenyRootAccount)
* Protect S3 Buckets (ProtectS3Buckets)
* Protect IAM Roles (ProtectIAMRoles)
* Restrict Regional Operations (LimitRegions)
* Require S3 encryption (DenyIncorrectEncryptionHeader + DenyUnEncryptedObjectUploads)


## Terraform Versions

_This is how we're managing the different versions._
Terraform 0.12. Pin module version to ~> 2.0. Submit pull-requests to master branch.

Terraform 0.11. Pin module version to ~> 1.0. Submit pull-requests to terraform011 branch.

### Usage for combined policy statements

To include a policy in your combined policy block, set it to `true`. Otherwise omit the policy variable.

```hcl
module "github_terraform_aws_ou_scp" {
  source = "trussworks/ou-scp/aws"
  target =  aws_organizations_organizational_unit.my_ou

  # don't allow all accounts to be able to leave the org
  deny_leaving_orgs             = true
  # applies to accounts that are not managing IAM users
  deny_creating_iam_users       = true
  # don't allow deleting KMS keys
  deny_deleting_kms_keys        = true
  # don't allow deleting Route53 zones
  deny_deleting_route53_zones   = true
  # don't allow deleting CloudWatch logs
  deny_deleting_cloudwatch_logs = true
  # don't allow access to the root user
  deny_root_account             = true

  protect_s3_buckets            = true
  # protect terraform statefile bucket
  protect_s3_bucket_resources   = [
    "arn:aws:s3:::prod-terraform-state-us-west-2",
    "arn:aws:s3:::prod-terraform-state-us-west-2/*"
  ]

  protect_iam_roles             = true
  # - protect OrganizationAccountAccessRole
  protect_iam_role_resources     = [
    "arn:aws:iam::*:role/OrganizationAccountAccessRole"
  ]

  # restrict region-specific operations to us-west-2
  limit_regions                 = true
  # - restrict region-specific operations to us-west-2
  allowed_regions               = ["us-west-2"]

  # require s3 objects be encrypted
  require_s3_encryption = true
}
```

### Usage for a policy which denies all access

```hcl
module "github_terraform_aws_ou_scp" {
  source = "trussworks/ou-scp/aws"
  target =  aws_organizations_organizational_unit.my_ou

  # don't allow any access at all
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
| deny\_root\_account | DenyRootAccount in the OU policy. | `bool` | `false` | no |
| limit\_regions | LimitRegions in the OU policy. | `bool` | `false` | no |
| protect\_iam\_role\_resources | IAM role resource ARNs to protect from modification and deletion | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| protect\_iam\_roles | ProtectIAMRoles in the OU policy. | `bool` | `false` | no |
| protect\_s3\_bucket\_resources | S3 bucket resource ARNs to protect from bucket and object deletion | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| protect\_s3\_buckets | ProtectS3Buckets in the OU policy. | `bool` | `false` | no |
| require\_s3\_encryption | DenyIncorrectEncryptionHeader and DenyUnEncryptedObjectUploads in the OU policy | `bool` | `false` | no |
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
