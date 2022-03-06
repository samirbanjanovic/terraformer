terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

provider "github" {}

module "terraformer" {
  source      = "./repo"
  repo_name   = "terraformer"
  description = "Terraform for creating and managing GitHub repos"
  provision_repo = false 
}

module "tankiMapper" {
  source       = "./repo"
  repo_name    = "TankiMapper"
  description  = "A light object-to-object mapper intended for simple mappings"
  has_projects = true
}

module "wayless" {
  source      = "./repo"
  repo_name   = "Wayless"
  description = "A lightweight object mapper"
}

module "terraform_template_test" {
  source      = "./repo"
  repo_name   = "terraform-template-test"
  description = "Terraform test repo created using dotnet template"
}