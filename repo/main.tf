resource "github_repository" "standard_repo" {
    name = var.repo_name
    description = var.description
    visibility = var.visibility
    has_projects = var.has_projects
    has_issues = var.has_issues
    delete_branch_on_merge = true
    license_template = "gpl-3.0"
}

resource "github_branch_protection" "branch_protection" {
    repository_id = var.repo_name
    require_conversation_resolution = true
    
    pattern = "main"
    required_pull_request_reviews {
        dismiss_stale_reviews = true
        required_approving_review_count = 1
             
    }
}