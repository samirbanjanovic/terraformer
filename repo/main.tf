resource "github_repository" "standard_repo" {
  name                   = var.repo_name
  description            = var.description
  visibility             = var.visibility
  has_projects           = var.has_projects
  has_issues             = var.has_issues
  has_wiki               = true
  has_downloads          = true
  vulnerability_alerts   = true
  gitignore_template = "VisualStudio"
  delete_branch_on_merge = true
  license_template       = "gpl-3.0"

  lifecycle {
    ignore_changes = [
      pages,
      gitignore_template

    ]
    prevent_destroy = true
  }

   provisioner "local-exec" {
    on_failure = continue
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
        git config --global user.name="Tarraformer"
        git config --global user.email="terraformer@coffeetocode.dev"
        
        mkdir tmp
        cd tmp
        git clone ${github_repository.standard_repo.http_clone_url}

        cd ${var.repo_name}
        dotnet new webapi -n "Terraform.Templated.Dotnet" -o .
        
        git add .
        git commit -m "Created code using standard template"

        git push

        cd ..
        rm -r ${var.repo_name}
        echo "WebApi template applied to repository `${var.repo_name}`."
        pwd
      EOT
  }
}

resource "github_branch_default" "main_as_default" {
  depends_on = [
    github_repository.standard_repo
  ]
  repository = var.repo_name
  branch = "main"
}

resource "github_branch_protection" "main_protection" {
  depends_on = [
    github_repository.standard_repo
  ]
  repository_id                   = var.repo_name
  require_conversation_resolution = true
  push_restrictions               = []
  pattern                         = "main"
  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    dismissal_restrictions          = []
    required_approving_review_count = 1

  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository_file" "readme" {
  depends_on = [
    github_repository.standard_repo
  ]
  repository     = var.repo_name
  branch         = "main"
  file           = "README.md"
  content        = "# ${var.repo_name}"
  commit_author  = "Terraform"
  commit_message = "File tracked via Terraform"
  commit_email   = "terraform@coffeetocode.dev"
  lifecycle {
    ignore_changes = [
      content,
      commit_author,
      commit_email,
      commit_message
    ]
    prevent_destroy = true
  }
}
