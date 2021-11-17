resource "cloudflare_zone" "sdhveselice_cz" {
  zone = "sdhveselice.cz"
}

resource "cloudflare_record" "sdhveselice_cz_v4" {
  zone_id = cloudflare_zone.sdhveselice_cz.id
  type    = "A"
  name    = "sdhveselice.cz"
  value   = "46.149.113.144"
  proxied = false
}

resource "cloudflare_record" "sdhveselice_cz_www_v4" {
  zone_id = cloudflare_zone.sdhveselice_cz.id
  type    = "A"
  name    = "www"
  value   = "46.149.113.144"
  proxied = false
}

resource "cloudflare_record" "sdhveselice_cz_mx_1" {
  zone_id  = cloudflare_zone.sdhveselice_cz.id
  type     = "MX"
  name     = "sdhveselice.cz"
  value    = "panda.bk.cz"
  proxied  = false
  priority = 10
}
