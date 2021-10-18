# My own infrastructure

Terraform is run manually from personal computer. It might be improvement to run terraform plan and terraform apply in
gitlab action.

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
