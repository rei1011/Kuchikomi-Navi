# # リクエストを正しいバックエンドサービスにルーティングする
# resource "google_compute_url_map" "url_map" {
#   name    = "url-map"
#   project = var.project
#   default_url_redirect {
#     strip_query            = true
#     redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
#   }
#   host_rule {
#     hosts        = [var.domain_name]
#     path_matcher = "path-matcher"
#   }
#   path_matcher {
#     name            = "path-matcher"
#     default_service = google_compute_backend_service.frontend_web_app.id
#     path_rule {
#       paths   = ["/*"]
#       service = google_compute_backend_service.frontend_web_app.id
#     }
#   }
# }

# # SSL証明書取得
# resource "google_compute_managed_ssl_certificate" "ssl-certificate" {
#   name    = "ssl-certificate"
#   project = var.project
#   managed {
#     domains = [google_dns_managed_zone.dns_zone.dns_name]
#   }
# }

# #  受信リクエストを正しいURLマップにルーティングさせ、SSL証明書も設定する
# resource "google_compute_target_https_proxy" "https-target-proxy" {
#   name             = "https-target-proxy"
#   project          = var.project
#   ssl_certificates = [google_compute_managed_ssl_certificate.ssl-certificate.id]
#   url_map          = google_compute_url_map.url_map.id
# }

# # グローバル転送ルールを設定し、特定のIPアドレスに届いたリクエストをプロキシへ転送する
# resource "google_compute_global_forwarding_rule" "forwarding-rule" {
#   project               = var.project
#   ip_address            = google_compute_global_address.lb-ip.address
#   ip_protocol           = "TCP"
#   load_balancing_scheme = "EXTERNAL_MANAGED"
#   name                  = "forwarding-rule"
#   port_range            = "443"
#   target                = google_compute_target_https_proxy.https-target-proxy.id
# }

# # サーバーレスネットワークエンドポイントグループ作成
# resource "google_compute_region_network_endpoint_group" "frontend_app" {
#   project               = var.project
#   name                  = "frontend-app"
#   network_endpoint_type = "SERVERLESS"
#   region                = var.region
#   cloud_run {
#     service = google_cloud_run_v2_service.default.name
#   }
# }

# # トラフィックの分散方法を定義
# resource "google_compute_backend_service" "frontend_web_app" {
#   project = var.project
#   name    = "frontend-web-app"
#   cdn_policy {
#     cache_key_policy {
#       include_host         = true
#       include_protocol     = true
#       include_query_string = true
#     }
#     cache_mode                   = "CACHE_ALL_STATIC"
#     client_ttl                   = 3600
#     default_ttl                  = 3600
#     max_ttl                      = 86400
#     signed_url_cache_max_age_sec = 0
#   }
#   connection_draining_timeout_sec = 0
#   enable_cdn                      = true
#   load_balancing_scheme           = "EXTERNAL_MANAGED"
#   locality_lb_policy              = "ROUND_ROBIN"
#   port_name                       = "http"
#   protocol                        = "HTTPS"
#   session_affinity                = "NONE"
#   timeout_sec                     = 30
#   backend {
#     group = google_compute_region_network_endpoint_group.frontend_app.id
#   }
# }