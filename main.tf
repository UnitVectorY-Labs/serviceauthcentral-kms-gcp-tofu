
resource "google_project_service" "kms" {
  project            = var.project_id
  service            = "cloudkms.googleapis.com"
  disable_on_destroy = false
}

# Check if the key ring already exists
data "google_kms_key_ring" "existing_key_ring" {
  count    = var.kms_existing_key ? 1 : 0
  project  = var.project_id
  name     = "serviceauthcentral-key-ring-${var.name}"
  location = "global"
}

# Create the KMS key ring only if it doesn't exist
resource "google_kms_key_ring" "sign_key_ring" {
  count    = var.kms_existing_key ? 0 : 1
  project  = var.project_id
  name     = "serviceauthcentral-key-ring-${var.name}"
  location = "global"
}

# Determine the correct key ring ID to use
locals {
  key_ring_id = var.kms_existing_key ? data.google_kms_key_ring.existing_key_ring[0].id: google_kms_key_ring.sign_key_ring[0].id
}

# Check if the crypto key already exists
data "google_kms_crypto_key" "existing_crypto_key" {
  count    = var.kms_existing_key ? 1 : 0
  name     = "serviceauthcentral-sign-key-${var.name}"
  key_ring = local.key_ring_id
}

# Create the crypto key only if it doesn't exist
resource "google_kms_crypto_key" "asymmetric_sign_key" {
  count                         = var.kms_existing_key ? 0 : 1
  name                          = "serviceauthcentral-sign-key-${var.name}"
  key_ring                      = local.key_ring_id
  purpose                       = "ASYMMETRIC_SIGN"
  destroy_scheduled_duration    = "86400s"
  skip_initial_version_creation = true

  version_template {
    protection_level = "SOFTWARE"
    algorithm        = "RSA_SIGN_PKCS1_2048_SHA256"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Local variable for the crypto key
locals {
  async_key      = var.kms_existing_key ? data.google_kms_crypto_key.existing_crypto_key[0].id : google_kms_crypto_key.asymmetric_sign_key[0].id
  key_ring_parts = split("/", local.async_key)
  key_ring_name  = local.key_ring_parts[5]
  sign_key_name  = local.key_ring_parts[7]
}