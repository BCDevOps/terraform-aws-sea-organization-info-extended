terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "3.11.0"
		}
	}
}

provider "aws" {
	region = "ca-central-1"
}

module "lz_info" {
	source = "github.com/BCDevOps/terraform-aws-sea-organization-info?ref=v0.0.2"
}

module "account_tags" {
	for_each = toset([for account in module.lz_info.workload_accounts : account.id ])

	source            = "digitickets/cli/aws"
	role_session_name = "account_tags_query"
	aws_cli_commands  = ["organizations", "list-tags-for-resource", "--resource-id", each.value]
}
