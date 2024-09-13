# Cloud DNSマネージドゾーンの作成
resource "google_dns_managed_zone" "dns_zone" {
  name        = "dns-zone"
  dns_name    = "${var.domain_name}."
  description = "Managed zone for example.com"

  dnssec_config {
    state = "on"
  }
}

# 静的IPアドレスの取得
resource "google_compute_global_address" "lb-ip" {
  project      = var.project
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
  name         = "lb-ip"
}

# 静的IPアドレスとドメインの紐付け
resource "google_dns_record_set" "lb-dns" {
  managed_zone = google_dns_managed_zone.dns_zone.name
  name         = "lb.${var.domain_name}."
  type         = "A"
  ttl          = 300
  rrdatas = [
    google_compute_global_address.lb-ip.address
  ]
}

# ドメインの登録
# 一度だけしか利用できないためコメントアウト
# resource "google_clouddomains_registration" "domain_registration" {
#   location    = "global"
#   domain_name = var.domain_name

#   yearly_price {
#     currency_code = "USD"
#     units         = 12
#   }

#   contact_settings {
#     privacy = "REDACTED_CONTACT_DATA"
#     registrant_contact {
#       phone_number = var.phone_number
#       email        = var.email
#       postal_address {
#         region_code   = var.region_code
#         postal_code   = var.postal_code
#         recipients    = var.recipients
#         locality      = var.locality
#         address_lines = var.address_lines
#       }
#     }

#     admin_contact {
#       phone_number = var.phone_number
#       email        = var.email
#       postal_address {
#         region_code   = var.region_code
#         postal_code   = var.postal_code
#         recipients    = var.recipients
#         locality      = var.locality
#         address_lines = var.address_lines
#       }
#     }

#     technical_contact {
#       phone_number = var.phone_number
#       email        = var.email
#       postal_address {
#         region_code   = var.region_code
#         postal_code   = var.postal_code
#         recipients    = var.recipients
#         locality      = var.locality
#         address_lines = var.address_lines
#       }
#     }
#   }

#   dns_settings {
#     custom_dns {
#       name_servers = google_dns_managed_zone.dns_zone.name_servers
#     }
#   }
# }