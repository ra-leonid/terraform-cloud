terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "ra-leonid"

    workspaces {
      name = "terraform-cloud"
      #prefix = "my-app-"
    }
  }

  required_version = ">= 0.14.0"
}
