variable "region"      { type = string }
variable "environment" { type = string }
variable "tier"        { type = string }
variable "network_id"  { type = string }
variable "db_password" { type = string, sensitive = true }
