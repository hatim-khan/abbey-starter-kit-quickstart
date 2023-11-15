terraform {
  backend "http" {
    address        = "https://api.abbey.io/terraform-http-backend"
    lock_address   = "https://api.abbey.io/terraform-http-backend/lock"
    unlock_address = "https://api.abbey.io/terraform-http-backend/unlock"
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
}

resource "abbey_grant_kit" "PagerDuty_Demo" {
  name = "PagerDuty_Demo"
  description = "PagerDuty demo"

  workflow = {
    steps = [
      {
        reviewers = {
          one_of = ["angie@abbey.io"] # CHANGEME
        },
        skip_if = [
          { bundle = "github://songe/abbey-quickstart-prod/policies/on-call" } # CHANGEME
        ]
      }
    ]
  }

  policies = [
    {
      query = <<REGO
      package common

      import data.abbey.functions

      allow[msg] {
          functions.expire_after("5m")
          msg := sprintf("granting access for %s", ["5m"])
      }
      REGO
    }
  ]

  output = {
    # Replace with your own path pointing to where you want your access changes to manifest.
    # Path is an RFC 3986 URI, such as `github://{organization}/{repo}/path/to/file.tf`.
    location = "github://songe/abbey-quickstart-prod/access.tf" # CHANGEME
    append = <<-EOT
      resource "abbey_demo" "grant_read_write_access" { # {{ .data.system.abbey.identities.abbey.email | printf "%stest" }}
        permission = "read_write"
        email = "{{ .data.system.abbey.identities.abbey.email }}"
      }
    EOT
  }
}

resource "abbey_grant_kit" "abbey_g_pumpkin" {
  name = "Abbey_Pumpkin_key"
  description = <<-EOT
    Grants access to Abbey's Demo Page.
  EOT

  workflow = {
    steps = [
      {
        reviewers = {
          one_of = ["hat@abbey.io"]
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

resource "abbey_grant_kit" "abbey_revoke_test_broken" {
  name = "Abbey_Revoke_V2"
  description = <<-EOT
    Grants access to Abbey's Demo Page.
  EOT

  workflow = {
    steps = [
      {
        reviewers = {
          one_of = ["hat@abbey.io"]
        }
      }
    ]
  }

  policies = [
    { bundle = "github:://hatim-khan/abbey-starter-kit-quickstart/policies" } # CHANGEME
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

