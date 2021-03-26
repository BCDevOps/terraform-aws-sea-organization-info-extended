
# License
<!--- [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](./LICENSE) --->

# SEA Organization Info Module ***Extended Remix Edition*** 

This repo provides a way to easily extract information about the accounts within an AWS Organzation that follows the SEA conventions.   

## Third-Party Products/Libraries used and the licenses they are covered by
<!--- product/library and path to the LICENSE --->
<!--- Example: <library_name> - [![GitHub](<shield_icon_link>)](<path_to_library_LICENSE>) --->

## Project Status
- [x] Development
- [ ] Production/Maintenance

## Documentation
You're looking at it!

This module is likely to be most useful - at least in its current state - as a standalone command-line "query" utility, rather than something to be used by other Terraform configuration.  This is becuase it is slow and also creates local resrouces so may "pollute" other state files.    

## Getting Started

- acquire/set a suitable AWS credential in your shell (or use `AWS_PROFILE` beofre `terraform` commands) that can read account organizations and tags.
- on the first use, run `terraform init`
- check setup via `terraform plan`
- generate the account data via `terraform apply`

Following `apply`, the account data is available as a Terraform `output` called "workload_accounts" (for basic compatiblity with the closely-related module at `bcdevops/terraform-aws-sea-organization-info`).  It can be viewed using `terraform output -json workload_accounts`.

### Creating a CSV report of accounts

The output can be massaged into a csv form using:

```shell
terraform output -json workload_accounts | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' > accounts_info.csv
```

### Creating an input file for the billing utility

An input file in a form usable with our billing report utility can be created using the following:

```shell
terraform output -json billing_report_input > billing_report_input.json 
```

The contents of `billing_report_input.json` can be provided to the billing utility and it will create corresponding reports.

## Getting Help or Reporting an Issue
<!--- Example below, modify accordingly --->
To report bugs/issues/feature requests, please file an [issue](../../issues).


## How to Contribute
<!--- Example below, modify accordingly --->
If you would like to contribute, please see our [CONTRIBUTING](./CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](./CODE_OF_CONDUCT.md). 
By participating in this project you agree to abide by its terms.


## License
    Copyright 2018 Province of British Columbia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
