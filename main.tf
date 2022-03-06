terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

provider "github" { }

module "tankiMapper" {
    source = "./repo"
    repo_name = "TankiMapper"
    description = "An ultra lean object-to-object mapper intended for simple mappings"
}

module "wayless" {

}