# My own infrastructure

[![Terraform](https://github.com/kozaktomas/infra/actions/workflows/terraform.yml/badge.svg)](https://github.com/kozaktomas/infra/actions/workflows/terraform.yml)

- `terraform plan` in pull requests
- `terraform apply` in the `main` branch

All changes are applied by Github actions. See workflows for more details.

## Expected environment variables:

All required variables are loaded in `./vars.sh` file.

## How to run terraform locally

```bash
./init # terraform should be initialized

# then you can run anything you want

terraform plan
terraform apply
terraform state pull
```

## Additional info

Secrets are not passed to pull request from forks. It means that Github actions
from forks will be failing. But it should be safe!
