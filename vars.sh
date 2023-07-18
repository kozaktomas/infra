#!/bin/bash

# load secrets from 1password

# shellcheck disable=SC2155
export TF_VAR_BACKEND_USERNAME="$(op read op://gha-kozaktomas-infra/tf-backend/user)"
export TF_VAR_BACKEND_TOKEN="$(op read op://gha-kozaktomas-infra/tf-backend/token)"
export TF_VAR_GOOGLE_PROJECT_ID="$(op read op://gha-kozaktomas-infra/gcloud/project_id)"
export GOOGLE_JSON_CONTENT="$(op read op://gha-kozaktomas-infra/gcloud/json)"
export TF_VAR_CLOUDFLARE_ACCOUNT_ID="$(op read op://gha-kozaktomas-infra/cloudflare/account_id)"
export TF_VAR_CLOUDFLARE_EMAIL="$(op read op://gha-kozaktomas-infra/cloudflare/email)"
export TF_VAR_CLOUDFLARE_API_KEY="$(op read op://gha-kozaktomas-infra/cloudflare/api_key)"
export TF_VAR_PLAYGROUND_VESELICE_ADMINS="$(op read op://gha-kozaktomas-infra/playground-veselice/admins)"
export TF_VAR_PLAYGROUND_VESELICE_DISCORD_URL="$(op read op://gha-kozaktomas-infra/playground-veselice/discord_hook)"
export TF_VAR_PLAYGROUND_VESELICE_JWT_SIGNING_KEY="$(op read op://gha-kozaktomas-infra/playground-veselice/jwt_signing_key)"
export TF_VAR_PLAYGROUND_VESELICE_JWT_PASSWORD_CHANGE_KEY="$(op read op://gha-kozaktomas-infra/playground-veselice/jwt_password_change_key)"
export TF_VAR_PLAYGROUND_VESELICE_REGISTRATION_CODE="$(op read op://gha-kozaktomas-infra/playground-veselice/registration_code)"
