resource "cloudflare_zone" "lojzatv_cz" {
  zone = "lojzatv.cz"
  account_id = var.CLOUDFLARE_ACCOUNT_ID
}

resource "cloudflare_record" "lojzatv_cz_ip_v4" {
  zone_id = cloudflare_zone.lojzatv_cz.id
  name    = "lojzatv.cz"
  type    = "A"
  value   = "49.13.69.212"
  proxied = false
}

resource "cloudflare_record" "lojzatv_cz_ip_v6" {
  zone_id = cloudflare_zone.lojzatv_cz.id
  name    = "lojzatv.cz"
  type    = "AAAA"
  value   = "2a01:4f8:c013:751::1"
  proxied = false
}
