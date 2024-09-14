
variable "application" {
  type = string
  description = "Application Name"
  default = "devops"
}
variable "environment" {
    type = string
    default = "dev"
    description = "Application Deployement Environment"
}
