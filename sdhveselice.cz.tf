resource "cloudflare_zone" "sdhveselice_cz" {
  zone = "sdhveselice.cz"
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
  type     = "MX"
  name     = "sdhveselice.cz"
  value    = "panda.bk.cz"
  proxied  = false
  priority = 10
}
