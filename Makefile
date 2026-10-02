# Publishing to the Ledger internal cargo registry.
#
# The `package` and `publish` targets are the contract that
# LedgerHQ/enclave-github-workflows/.github/workflows/job-rust-publish.yml
# expects from a repository it publishes.

CARGO          ?= cargo
CARGO_REGISTRY ?= enclave-cargo-prod-green

.PHONY: all build test fmt fmt.check clippy package publish

all: build

build:
	$(CARGO) build

test:
	$(CARGO) test

fmt:
	$(CARGO) fmt --all

fmt.check:
	$(CARGO) fmt --all -- --check

clippy:
	$(CARGO) clippy -- -D warnings -A clippy::branches_sharing_code

# Packages the crate without uploading anything, so a broken package fails
# before the publish step runs.
package:
	$(CARGO) package --list

publish:
	$(CARGO) publish --registry $(CARGO_REGISTRY)
