# My own infrastructure

[![Terraform](https://github.com/kozaktomas/infra/actions/workflows/terraform.yml/badge.svg)](https://github.com/kozaktomas/infra/actions/workflows/terraform.yml)

- `terraform plan` in pull requests
- `terraform apply` in the `main` branch

All changes are applied by Github actions. See workflows for more details.

## Expected environment variables:

Variables could be provided by maintainer(s).

- TF_VAR_BACKEND_USERNAME=johndoe
- TF_VAR_BACKEND_TOKEN=API_TOKEN
- TF_VAR_CLOUDFLARE_EMAIL=johndoe@gmail.com
- TF_VAR_CLOUDFLARE_API_KEY=API_TOKEN

## How to run terraform

```bash
./init # terraform should be initialized

# then you can run anything you want

terraform plan
terraform apply
terraform state pull
```

## Additional info

Secrets are not passed to pull request from forks. It means that Github actions from forks will be failing. But, it
should be safe!