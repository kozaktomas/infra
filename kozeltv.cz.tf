resource "cloudflare_zone" "kozeltv_cz" {
  zone = "kozeltv.cz"
}

resource "cloudflare_record" "kozeltv_cz_ip_v4" {
  zone_id = cloudflare_zone.kozeltv_cz.id
  name    = "kozeltv.cz"
  type    = "A"
  value   = "89.221.215.36"
  proxied = false
}

resource "cloudflare_record" "kozeltv_cz_ip_v6" {
  zone_id = cloudflare_zone.kozeltv_cz.id
  name    = "kozeltv.cz"
  type    = "AAAA"
  value   = "2a02:2b88:2:424::"
  proxied = false
}
