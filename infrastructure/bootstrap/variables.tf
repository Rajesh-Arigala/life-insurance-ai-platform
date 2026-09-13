variable "project_code" {
  description = "Short project code."
  type        = string
  default     = "liai"
}

variable "location" {
  description = "Azure region for Terraform state infrastructure."
  type        = string
  default     = "centralindia"
}

variable "region_code" {
  description = "Short Azure region code."
  type        = string
  default     = "cin"
}

variable "instance" {
  description = "Resource instance identifier."
  type        = string
  default     = "001"
}

variable "owner" {
  description = "Owner of the Terraform state infrastructure."
  type        = string
  default     = "rajesh-arigala"
}

variable "state_container_name" {
  description = "Blob container used for Terraform state."
  type        = string
  default     = "tfstate"
}
