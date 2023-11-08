resource "cloudflare_zone" "kozak_in" {
  zone       = "kozak.in"
  account_id = var.CLOUDFLARE_ACCOUNT_ID
}

resource "cloudflare_record" "kozak_in_ip_v4" {
  zone_id = cloudflare_zone.kozak_in.id
  name    = "kozak.in"
  type    = "A"
  value   = "49.13.69.212"
  proxied = true
}

resource "cloudflare_record" "kozak_in_ip_v6" {
  zone_id = cloudflare_zone.kozak_in.id
  name    = "kozak.in"
  type    = "AAAA"
  value   = "2a01:4f8:c013:751::1"
  proxied = true
}

resource "cloudflare_record" "mimir_kozak_in_ip_v4" {
  zone_id = cloudflare_zone.kozak_in.id
  type    = "A"
  name    = "mimir"
  value   = "49.13.69.212"
}

resource "cloudflare_record" "mimir_kozak_in_ip_v6" {
  zone_id = cloudflare_zone.kozak_in.id
  type    = "AAAA"
  name    = "mimir"
  value   = "2a01:4f8:c013:751::1"
}

resource "cloudflare_record" "kozak_in_mx_1" {
  zone_id  = cloudflare_zone.kozak_in.id
  name     = "kozak.in"
  type     = "MX"
  value    = "ffbf8aab17100078.mx1.emailprofi.seznam.cz"
  priority = 20
  proxied  = false
}

resource "cloudflare_record" "kozak_in_mx_2" {
  zone_id  = cloudflare_zone.kozak_in.id
  name     = "kozak.in"
  type     = "MX"
  value    = "ffbf8aab17100078.mx2.emailprofi.seznam.cz"
  priority = 10
  proxied  = false
}

resource "cloudflare_record" "kozak_in_spf" {
  zone_id = cloudflare_zone.kozak_in.id
  name    = "kozak.in"
  type    = "TXT"
  value   = "v=spf1 include:spf.seznam.cz ~all"
}

resource "cloudflare_record" "kozak_in_google_verification" {
  zone_id = cloudflare_zone.kozak_in.id
  name    = "kozak.in"
  type    = "TXT"
  value   = "google-site-verification=KUYM3CgBnxvUpUz4_Kn9m17cX8SqTZ5IFKQ7rOukCwA"
}
