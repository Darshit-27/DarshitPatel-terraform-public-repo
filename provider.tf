terraform {
  cloud {
    organization = "darshit-org"

    workspaces {
      name = "terraform-nginx-project"
    }
  }
}
