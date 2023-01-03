resource "cloudflare_zone" "sdhveselice_cz" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  zone       = "sdhveselice.cz"
}

resource "cloudflare_record" "sdhveselice_cz" {
  zone_id = cloudflare_zone.sdhveselice_cz.id
  type    = "CNAME"
  name    = "sdhveselice.cz"
  value   = "sdhveselice.pages.dev"
  proxied = true
  ttl     = 1
}

resource "cloudflare_record" "sdhveselice_cz_www_v4" {
  zone_id = cloudflare_zone.sdhveselice_cz.id
  type    = "CNAME"
  name    = "www.sdhveselice.cz"
  value   = "sdhveselice.pages.dev"
  proxied = true
  ttl     = 1
}

resource "cloudflare_record" "sdhveselice_cz_mx_1" {
  zone_id  = cloudflare_zone.sdhveselice_cz.id
  name     = "sdhveselice.cz"
  type     = "MX"
  value    = "70c1c31657325d2a.mx1.emailprofi.seznam.cz"
  priority = 20
  proxied  = false
}

resource "cloudflare_record" "sdhveselice_cz_mx_2" {
  zone_id  = cloudflare_zone.sdhveselice_cz.id
  name     = "sdhveselice.cz"
  type     = "MX"
  value    = "70c1c31657325d2a.mx2.emailprofi.seznam.cz"
  priority = 10
  proxied  = false
}
