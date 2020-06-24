# Truss Terraform Module template

This repository is meant to be a template repo we can just spin up new module repos from with our general format.

## Creating a new Terraform Module

1. Clone this repo, renaming appropriately.
1. Write your terraform code in the root dir.
1. Create an example of the module in use in the `examples` dir.
1. Ensure you've completed the [Developer Setup](#developer-setup).
1. Write terratests in the `test` dir.
1. [With slight modification from the Terratest docs](https://github.com/gruntwork-io/terratest#setting-up-your-project): In the root dir, run `go mod init MODULE_NAME` to get a new go.mod file. Then run `go mod tidy` to download terratest.
1. Run your tests to ensure they work as expected using instructions below.

## Actual readme below  - Delete above here

Please put a description of what this module does here

## Terraform Versions

_This is how we're managing the different versions._
Terraform 0.12. Pin module version to ~> 2.0. Submit pull-requests to master branch.

Terraform 0.11. Pin module version to ~> 1.0. Submit pull-requests to terraform011 branch.

## Usage

### Put an example usage of the module here

```hcl
module "example" {
  source = "terraform/registry/path"

  <variables>
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

No provider.

## Inputs

No input.

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Developer Setup

Install dependencies (macOS)

```shell
brew install pre-commit go terraform terraform-docs
pre-commit install --install-hooks
```

### Testing

[Terratest](https://github.com/gruntwork-io/terratest) is being used for
automated testing with this module. Tests in the `test` folder can be run
locally by running the following command:

```text
make test
```

Or with aws-vault:

```text
AWS_VAULT_KEYCHAIN_NAME=<NAME> aws-vault exec <PROFILE> -- make test
```

### A Note About Golang and Imports

In order to import the dependencies required to set up Terratest metadata in CircleCI, this repository contains initialized (and populated) `go.mod` and `go.sum` files. Delete these files to set up your own project, and run `go mod init YOUR_SHINY_NEW_REPO` as usual to create these files and pull in these initial dependencies for your own shiny new repository when you make your vendoring decisions.

