resource "cloudflare_zone" "kotrzina_cz" {
  zone = "kotrzina.cz"
  account_id = var.CLOUDFLARE_ACCOUNT_ID
}

resource "cloudflare_record" "kotrzina_cz_cname" {
  zone_id = cloudflare_zone.kotrzina_cz.id
  type    = "CNAME"
  name    = "kotrzina.cz"
  value   = "kotrzina.pages.dev"
  proxied = true
  ttl     = 1
}

resource "cloudflare_record" "hriste_kotrzina_cz_cname" {
  zone_id = cloudflare_zone.kotrzina_cz.id
  type    = "CNAME"
  name    = "hriste"
  value   = "hriste.pages.dev"
  proxied = true
  ttl     = 1
}

resource "cloudflare_record" "pub_kotrzina_cz" {
  zone_id = cloudflare_zone.kotrzina_cz.id
  name    = "pub"
  type    = "A"
  value   = "49.13.69.212"
  proxied = false
}

resource "cloudflare_record" "pub_kotrzina_cz_ip_v6" {
  zone_id = cloudflare_zone.kotrzina_cz.id
  name    = "pub"
  type    = "AAAA"
  value   = "2a01:4f8:c013:751::1"
  proxied = false
}

resource "cloudflare_record" "kotrzina_cz_mx_1" {
  zone_id  = cloudflare_zone.kotrzina_cz.id
  name     = "kotrzina.cz"
  type     = "MX"
  value    = "f8d0f93381194a64.mx1.emailprofi.seznam.cz"
  priority = 20
  proxied  = false
}

resource "cloudflare_record" "kotrzina_cz_mx_2" {
  zone_id  = cloudflare_zone.kotrzina_cz.id
  name     = "kotrzina.cz"
  type     = "MX"
  value    = "f8d0f93381194a64.mx2.emailprofi.seznam.cz"
  priority = 10
  proxied  = false
}
