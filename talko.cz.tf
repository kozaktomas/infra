resource "cloudflare_zone" "talko_cz" {
  zone = "talko.cz"
}

resource "cloudflare_record" "talko_cz_ip_v4" {
  zone_id = cloudflare_zone.talko_cz.id
  name    = "talko.cz"
  type    = "A"
  value   = "46.28.105.4"
  proxied = false
}

resource "cloudflare_record" "talko_cz_ip_v6" {
  zone_id = cloudflare_zone.talko_cz.id
  name    = "talko.cz"
  type    = "AAAA"
  value   = "2a02:2b88:1:4::18"
  proxied = false
}

resource "cloudflare_record" "talko_cz_mx_1" {
  zone_id  = cloudflare_zone.talko_cz.id
  name     = "talko.cz"
  type     = "MX"
  value    = "fd4254882db38f5b.mx1.emailprofi.seznam.cz"
  priority = 20
  proxied  = false
}

resource "cloudflare_record" "talko_cz_mx_2" {
  zone_id  = cloudflare_zone.talko_cz.id
  name     = "talko.cz"
  type     = "MX"
  value    = "fd4254882db38f5b.mx2.emailprofi.seznam.cz"
  priority = 10
  proxied  = false
}

resource "cloudflare_record" "talko_cz_spf" {
  zone_id = cloudflare_zone.talko_cz.id
  name    = "talko.cz"
  type    = "TXT"
  value   = "v=spf1 include:spf.seznam.cz ~all"
}

resource "cloudflare_record" "talko_cz_dmarc" {
  zone_id = cloudflare_zone.talko_cz.id
  name    = "_dmarc"
  type    = "TXT"
  value   = "v=DMARC1; p=none; rua=mailto:kozak@talko.cz"
}
