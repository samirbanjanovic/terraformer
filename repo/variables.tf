variable "repo_name" {
  type = string
  nullable = false
}

variable "description" {
    type = string
    default = "Fun new things are coming your way"
}

variable "visibility" {
    type = string
    default = "public"
}

variable "has_projects" {
    type = bool
    default = true
}

variable "has_issues" {
    type = bool
    default = true
}