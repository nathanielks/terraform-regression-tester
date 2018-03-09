#!/usr/bin/env bash
set -xuo pipefail

VERSIONS="${VERSIONS-:"v0.11.3 v0.10.8 v0.9.9 v0.8.8 v0.7.9"}"
TERRAFORM_DIR="${TERRAFORM_DIR:-"${GOPATH}/src/github.com/hashicorp/terraform"}"
WORKING_DIR="${WORKING_DIR:-"$(pwd)"}"
TEST_COMMAND="${TEST_COMMAND:-"terraform plan"}"
LOG_DIR="${LOG_DIR:=.}"
(
for VERSION in $VERSIONS; do
	cd "$TERRAFORM_DIR" || return 1
	echo "Checking out $VERSION"
	git reset --hard
	git	checkout "$VERSION"

	echo "Building $VERSION"
	go install github.com/hashicorp/terraform

	echo "Verifying terraform binary is correct version"
	RESULT="$(terraform -v | grep "Terraform $VERSION")"
	SUCCESS="$?"

	if [[ ! "$SUCCESS" -eq 0 ]]; then
		echo "Version mismatch! expected $VERSION, got $RESULT" && exit 1
	fi

	cd "$WORKING_DIR" || return 1
	echo "Testing regression"
	$TEST_COMMAND > >(tee -a "${LOG_DIR}/${VERSION}.log") 2>&1
done
)
