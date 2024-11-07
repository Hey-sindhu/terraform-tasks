terraform {
  cloud {

    organization = "terraform-abc"

    workspaces {
      name = "Production_env"
    }
  }
}
