# Variables
variable "resource_group_name" {
  default = "my-functionapp-rg"
}

variable "location" {
  default = "East US"
}

variable "function_app_name" {
  default = "my-function-app"
}

variable "storage_account_name" {
  default = "myfuncstorage1234"
}

variable "app_service_plan_name" {
  default = "my-function-plan"
}