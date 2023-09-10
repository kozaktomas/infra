resource "cloudflare_zone" "kozeltv_cz" {
  zone = "kozeltv.cz"
}

resource "cloudflare_record" "kozeltv_cz_ip_v4" {
  zone_id = cloudflare_zone.kozeltv_cz.id
  name    = "kozeltv.cz"
  type    = "A"
  value   = "49.13.69.212"
  proxied = false
}

resource "cloudflare_record" "kozeltv_cz_ip_v6" {
  zone_id = cloudflare_zone.kozeltv_cz.id
  name    = "kozeltv.cz"
  type    = "AAAA"
  value   = "2a01:4f8:c013:751::1"
  proxied = false
}
