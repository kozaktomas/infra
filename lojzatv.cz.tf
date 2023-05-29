resource "cloudflare_zone" "lojzatv_cz" {
  zone = "lojzatv.cz"
}

resource "cloudflare_record" "lojzatv_cz_ip_v4" {
  zone_id = cloudflare_zone.lojzatv_cz.id
  name    = "lojzatv.cz"
  type    = "A"
  value   = "89.221.215.36"
  proxied = false
}

resource "cloudflare_record" "lojzatv_cz_ip_v6" {
  zone_id = cloudflare_zone.lojzatv_cz.id
  name    = "lojzatv.cz"
  type    = "AAAA"
  value   = "2a02:2b88:2:424::"
  proxied = false
}
