# Volumes

resource "google_storage_bucket" "foundations_caddy_public_server_data" {
  name                        = "foundations-us-west1-a-1-caddy-public-data"
  location                    = "US-WEST1"
  force_destroy               = true
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  encryption {
    default_kms_key_name = google_kms_crypto_key.bucket_us_west1_1_1.id
  }
}
