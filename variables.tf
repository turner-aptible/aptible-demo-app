### APTIBLE ###

variable "aptible_environment" {
  description = "Name of the Aptible Environment you'd like to use."
  type        = string
}

# Uncomment if you like to specify an org_id for the stack
variable "org_id" {
  description = "Organization you'd like to create the resources in if you are a member of multiple orgs."
  type = string
}

variable "aptible_stack" {
  description = "Name of the stack when creating the environment."
  type = string
}