output "repo_url" {
    value = github_repository.standard_repo.html_url
}

output "clone_url" {
    value = github_repository.standard_repo.http_clone_url
}

output "branches" {
    value = github_repository.standard_repo.branches
}