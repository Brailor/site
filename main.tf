terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


variable "do_token" {
  type        = string
  sensitive   = true
  description = "token for authorizing to digitalocean"
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_app" "static-ste-example" {
  spec {
    name   = "brailor-static-site"
    region = "fra1"

    static_site {
      name          = "brailor-site-hugo"
      build_command = "hugo"
      output_dir    = "/public"

      github {
        repo   = "Brailor/site"
        branch = "master"
      }
    }
  }
}
