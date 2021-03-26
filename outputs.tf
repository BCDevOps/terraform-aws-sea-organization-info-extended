
// a list of workload accounts "augemented" with attributes for each tag they have attached to them.  compatible structure to `terraform-aws-sea-organizaiton-info`.
output "workload_accounts" {
	value = local.tagged_workload_accounts
}

// a map of billing_group values and their associated list of accounts
output "accounts_by_billing_group" {
	value = local.accounts_by_billing_group
}

// a map structure containing account information and time-based query paramaters in a form that may be used as an input into our billing report generation utility.
output "billing_report_input" {
	value = local.billing_report_input
}
