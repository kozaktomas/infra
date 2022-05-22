# My own infrastructure

[![Terraform](https://github.com/kozaktomas/infra/actions/workflows/terraform.yml/badge.svg)](https://github.com/kozaktomas/infra/actions/workflows/terraform.yml)

- `terraform plan` in pull requests
- `terraform apply` in the `main` branch

All changes are applied by Github actions. See workflows for more details.

## Expected environment variables:

- TF_VAR_BACKEND_USERNAME=johndoe
- TF_VAR_BACKEND_TOKEN=API_TOKEN
- TF_VAR_CLOUDFLARE_EMAIL=johndoe@gmail.com
- TF_VAR_CLOUDFLARE_API_KEY=API_TOKEN
- TF_VAR_GOOGLE_PROJECT_ID=project-123456
- TF_VAR_PLAYGROUND_VESELICE_JWT_SIGNING_KEY=key
- TF_VAR_PLAYGROUND_VESELICE_REGISTRATION_CODE=code
- TF_VAR_PLAYGROUND_VESELICE_ADMINS=admin1,admin2
- TF_VAR_PLAYGROUND_VESELICE_DISCORD_URL=https://discordapp.com/api/webhooks/id/token-

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
