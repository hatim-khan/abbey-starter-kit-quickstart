terraform {
  backend "http" {
    address        = "http://localhost:8080/terraform-http-backend"
    lock_address   = "http://localhost:8080/terraform-http-backend/lock"
    unlock_address = "http://localhost:8080/terraform-http-backend/unlock"
    lock_method    = "POST"
    unlock_method  = "POST"
  }

  required_providers {
    abbey = {
      source = "abbeylabs/abbey"
      version = "0.2.4"
    }
  }
}

provider "abbey" {
  # Configuration options
  bearer_auth = var.abbey_token
  server_url = "http://localhost:8080/v1/"
}

resource "abbey_grant_kit" "abbey_quickstart_grant_kit" {
  name = "Abbey_Quickstart_Grant_kit"
  description = <<-EOT
    Grants access to Abbey's Demo Page.
  EOT

  workflow = {
    steps = [
      {
        reviewers = {
          one_of = ["hat+test@abbey.io"]
        }
      }
    ]
  }

  policies = [
    { bundle = "github://hatim-khan/abbey-starter-kit-quickstart/policies" } # CHANGEME
  ]

  output = {
    # Replace with your own path pointing to where you want your access changes to manifest.
    # Path is an RFC 3986 URI, such as `github://{organization}/{repo}/path/to/file.tf`.
    location = "github://hatim-khan/abbey-starter-kit-quickstart/access.tf" # CHANGEME
    append = <<-EOT
      resource "abbey_demo" "grant_read_write_access" {
        permission = "read_write"
        email = "{{ .data.system.abbey.identities.abbey.email }}"
      }
    EOT
  }
}

