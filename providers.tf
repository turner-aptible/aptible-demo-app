terraform {
  required_providers {
    aptible = {
      source  = "aptible/aptible"
      version = ">=0.6.0"
    }
  }
}

provider "aptible" {
}