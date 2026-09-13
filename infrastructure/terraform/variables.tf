variable "project_name" {
  description = "Full project name."
  type        = string
  default     = "life-insurance-ai"
}

variable "project_code" {
  description = "Short project code used in Azure resource names."
  type        = string
  default     = "liai"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}

variable "location" {
  description = "Primary Azure region."
  type        = string
  default     = "centralindia"
}

variable "region_code" {
  description = "Short region code used in resource names."
  type        = string
  default     = "cin"
}

variable "instance" {
  description = "Resource instance identifier."
  type        = string
  default     = "001"
}

variable "owner" {
  description = "Resource owner."
  type        = string
  default     = "rajesh-arigala"
}

variable "allowed_public_ip" {
  description = "Public IPv4 address allowed through Storage and Key Vault firewalls."
  type        = string
}

variable "monthly_budget_amount" {
  description = "Monthly Azure DEV budget in the subscription billing currency."
  type        = number
  default     = 500
}

variable "budget_start_date" {
  description = "Budget start date. Must be the first day of the month in UTC."
  type        = string
}
