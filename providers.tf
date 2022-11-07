terraform {
  required_providers {
    aptible = {
      source  = "aptible/aptible"
      version = ">=0.7.2"
    }
  }
}

provider "aptible" {
}