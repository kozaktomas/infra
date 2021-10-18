# Cloudflare doc

#### How to get zone ID for import:

```bash
curl -X GET "https://api.cloudflare.com/client/v4/zones" \
    -H "X-Auth-Email: $TF_VAR_CLOUDFLARE_EMAIL" \
    -H "X-Auth-Key: $TF_VAR_CLOUDFLARE_API_KEY" \
    -H "Content-Type: application/json" | jq '.result[] | {id,name}'
```

#### How to get dns record in zone:

```bash
export ZONE_ID=abcd # fill me
curl -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
    -H "X-Auth-Email: $TF_VAR_CLOUDFLARE_EMAIL" \
    -H "X-Auth-Key: $TF_VAR_CLOUDFLARE_API_KEY" \
    -H "Content-Type: application/json" | jq '.result[] | {id, name, type, content, proxiable, proxied, ttl, priority}'
```