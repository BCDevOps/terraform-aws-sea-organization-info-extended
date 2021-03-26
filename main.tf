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
	for_each = toset([for account in module.lz_info.workload_accounts : account.id])

	source = "digitickets/cli/aws"
	role_session_name = "account_tags_query"
	aws_cli_commands = [
		"organizations",
		"list-tags-for-resource",
		"--resource-id",
		each.value]
}

locals {

	tagged_workload_accounts = [for account in module.lz_info.workload_accounts : merge(account, {for tag in module.account_tags[account.id].result["Tags"] :
	tag["Key"] => tag["Value"]
	})]

	accounts_by_billing_group = {for account in local.tagged_workload_accounts : lookup(account, "billing_group", "NOGROUP") => account...}

	billing_report_input = {
		month: 2,
		year: 2021,
		teams: [for billing_group, accounts in local.accounts_by_billing_group : {
			contact_name = accounts[0]["admin_contact_name"]
			contact_email: accounts[0]["admin_contact_email"]
			business_unit: accounts[0]["billing_group"],
			accountIds: [for a in accounts : a["id"]
			]
		} if billing_group != "NOGROUP"]
	}
}
