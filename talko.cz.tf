// 88f39cacb5ad1001d7bea4599217044b
resource "cloudflare_zone" "talko_cz" {
  zone = "talko.cz"
}

// terraform import cloudflare_record.talko_cz_ip_v4 88f39cacb5ad1001d7bea4599217044b/ff62aec6d0aa46982f22ffae0716ca32
resource "cloudflare_record" "talko_cz_ip_v4" {
  zone_id = cloudflare_zone.talko_cz.id
  name    = "talko.cz"
  type    = "A"
  value   = "46.28.105.4"
  proxied = false
}

// terraform import cloudflare_record.talko_cz_ip_v6 88f39cacb5ad1001d7bea4599217044b/facb628394deaf5af5eaafbe0e7ab0d6
resource "cloudflare_record" "talko_cz_ip_v6" {
  zone_id = cloudflare_zone.talko_cz.id
  name    = "talko.cz"
  type    = "AAAA"
  value   = "2a02:2b88:1:4::18"
  proxied = false
}

// terraform import cloudflare_record.talko_cz_mx_1 88f39cacb5ad1001d7bea4599217044b/ec11849c60860a684c323aa1616e1e5f
resource "cloudflare_record" "talko_cz_mx_1" {
  zone_id  = cloudflare_zone.talko_cz.id
  name     = "talko.cz"
  type     = "MX"
  value    = "fd4254882db38f5b.mx1.emailprofi.seznam.cz"
  priority = 20
  proxied  = false
}

// terraform import cloudflare_record.talko_cz_mx_2 88f39cacb5ad1001d7bea4599217044b/4ef95e764a8a8f2887c94c4f21d74abe
resource "cloudflare_record" "talko_cz_mx_2" {
  zone_id  = cloudflare_zone.talko_cz.id
  name     = "talko.cz"
  type     = "MX"
  value    = "fd4254882db38f5b.mx2.emailprofi.seznam.cz"
  priority = 10
  proxied  = false
}

// terraform import cloudflare_record.talko_cz_spf 88f39cacb5ad1001d7bea4599217044b/47b080b2a226313c71d0cedea87fe206
resource "cloudflare_record" "talko_cz_spf" {
  zone_id = cloudflare_zone.talko_cz.id
  name    = "talko.cz"
  type    = "TXT"
  value   = "v=spf1 include:spf.seznam.cz ~all"
}

// terraform import cloudflare_record.talko_cz_dmarc 88f39cacb5ad1001d7bea4599217044b/271f604ccf4bb207f8c069532415d65c
resource "cloudflare_record" "talko_cz_dmarc" {
  zone_id = cloudflare_zone.talko_cz.id
  name    = "_dmarc"
  type    = "TXT"
  value   = "v=DMARC1; p=none; rua=mailto:kozak@talko.cz"
}
