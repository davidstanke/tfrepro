provider "google" {
  project = var.project-id
  region = "us-central1"
}

resource "google_storage_bucket" "bucket" {
  name = "${var.project-id}-functions-source"
}

# place the zip-ed code in the bucket
resource "google_storage_bucket_object" "function_source" {
 name   = "functionsource.zip"
 bucket = "google_storage_bucket.bucket.${var.project-id}-functions-source"
 source = functionsource.zip
}

resource "google_cloudfunctions_function" "myfunction" {

  name     = examplefunction
  runtime  = "nodejs8"

  available_memory_mb   = 128
  source_archive_bucket = "google_storage_bucket.bucket.${var.project-id}-functions-source"
  source_archive_object = functionsource.zip
  entry_point           = helloworld
  trigger_http          = true
}
