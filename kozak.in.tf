resource "cloudflare_zone" "kozak_in" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  zone       = "kozak.in"
}

resource "cloudflare_record" "kozak_in_ip_v4" {
  zone_id = cloudflare_zone.kozak_in.id
  name    = "kozak.in"
  type    = "A"
  value   = "89.221.215.36"
  proxied = true
}

resource "cloudflare_record" "kozak_in_grafana" {
  zone_id = cloudflare_zone.kozak_in.id
  name    = "grafana.kozak.in"
  type    = "A"
  value   = "89.221.215.36"
  proxied = true
}

resource "cloudflare_record" "kozak_in_prom" {
  zone_id = cloudflare_zone.kozak_in.id
  name    = "prom.kozak.in"
  type    = "A"
  value   = "89.221.215.36"
  proxied = true
}

resource "cloudflare_record" "kozak_in_push_gateway" {
  zone_id = cloudflare_zone.kozak_in.id
  name    = "push.kozak.in"
  type    = "A"
  value   = "89.221.215.36"
  proxied = true
}

resource "cloudflare_record" "kozak_in_alertmanager" {
  zone_id = cloudflare_zone.kozak_in.id
  name    = "alertmanager.kozak.in"
  type    = "A"
  value   = "89.221.215.36"
  proxied = true
}

resource "cloudflare_record" "kozak_in_ip_v6" {
  zone_id = cloudflare_zone.kozak_in.id
  name    = "kozak.in"
  type    = "AAAA"
  value   = "2a02:2b88:2:424::0"
  proxied = true
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

resource "cloudflare_record" "kozak_in_miluji_praci_old" {
  zone_id = cloudflare_zone.kozak_in.id
  type    = "CNAME"
  name    = "slack-milujipraci"
  value   = "ghs.googlehosted.com"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "kozak_in_miluji_praci" {
  zone_id = cloudflare_zone.kozak_in.id
  type    = "CNAME"
  name    = "milujipraci"
  value   = "ghs.googlehosted.com"
  proxied = false
  ttl     = 1
}
