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


locals {
  account_name = "hatim-khan"
  repo_name = "abbey-starter-kit-quickstart"

  repo = "github://${local.account_name}/${local.repo_name}"
  output_location = "${local.repo}/access.tf"
  policies = "${local.repo}/policies"
}

provider "abbey" {
  # Configuration options
  bearer_auth = var.abbey_token
}


resource "abbey_grant_kit" "abbey_gk_local_vars" {
  name = "abbey_gk_local_vars"
  description = <<-EOT
    Grants access to Abbey's Demo Page using local variables.
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
    { bundle = local.policies } # CHANGEME
  ]

  output = {
    location = local.output_location
    append = <<-EOT
      resource "abbey_demo" "grant_read_write_access_local_vars" {
        permission = "read_write"
        email = "{{ .user.email }}"
      }
    EOT
  }
}

resource "abbey_grant_kit" "abbey_demo_site_one" {
  name = "abbey_demo_site_one"
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
      resource "abbey_demo" "grant_read_write_access_one" {
        permission = "read_write"
        email = "{{ .user.email }}"
      }
    EOT
  }
}

resource "abbey_grant_kit" "abbey_demo_site_reviewer_not_in_org" {
  name = "abbey_demo_site_reviewer_not_in_org"
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
      resource "abbey_demo" "grant_read_write_access_one" {
        permission = "read_write"
        email = "{{ .user.email }}"
      }
    EOT
  }
}

resource "abbey_grant_kit" "abbey_demo_site_two" {
  name = "abbey_demo_site_two"
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
      resource "abbey_demo" "grant_read_write_access_two" {
        permission = "read_write"
        email = "{{ .user.email }}"
      }
    EOT
  }
}

resource "abbey_grant_kit" "abbey_demo_site_three" {
  name = "abbey_demo_site_three"
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
      resource "abbey_demo" "grant_read_write_access_three" {
        permission = "read_write"
        email = "{{ .user.email }}"
      }
    EOT
  }
}

resource "abbey_grant_kit" "abbey_valid_gk" {
  name = "abbey_valid_grant_kit"
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
        email = "{{ .user.email }}"
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
    { bundle = "github://hatim-khan/abbey-starter-kit-quickstart/policies" } # CHANGEME
  ]

  output = {
    # Replace with your own path pointing to where you want your access changes to manifest.
    # Path is an RFC 3986 URI, such as `github://{organization}/{repo}/path/to/file.tf`.
    location = "github://hatim-khan/abbey-starter-kit-quickstart/access.tf" # CHANGEME
    append = <<-EOT
      resource "abbey_demo" "grant_read_write_access" {
        permission = "read_write"
        email = "{{ .user.email }}"
      }
    EOT
  }
}

