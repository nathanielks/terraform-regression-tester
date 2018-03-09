# Terraform Regression Tester

## Usage

Note: this assumes you have Terraform installed via Go and `$GOPATH/bin` has a higher priority in your `$PATH` than `/usr/local/bin` (in the event you have `terraform` installed via `brew`).

```
git clone https://github.com/nathanielks/terraform-regression-tester
cd terraform-regression-tester
WORKING_DIR=/path/to/terraform/config ./test.sh
```

This script will compile certain versions of Terraform (`VERSIONS` in the script), build and install that version of Terraform, and run the `TEST_COMMAND` in the `WORKING_DIR`, outputing logs by default to the directory the script is being executed in (`.`).

For example, `test.sh` lives in `/Users/foobar/code/terraform-regression-tester`,  `WORKING_DIR` is `/Users/foobar/code/terraform`, `TERRAFORM_DIR` is `${GOPATH}/src/github.com/hashicorp/terraform`, and you're running the script from `/Users/foobar/code/terraform-regression-tester`, logs will be output in `/Users/foobar/code/terraform-regression-tester`.
