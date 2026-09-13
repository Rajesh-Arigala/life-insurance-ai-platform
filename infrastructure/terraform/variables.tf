variable "project_name" {
  description = "Short name for the Life Insurance AI Platform."
  type        = string
  default     = "life-insurance-ai"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Primary Azure region."
  type        = string
  default     = "centralindia"
}

variable "owner" {
  description = "Owner of the deployed resources."
  type        = string
  default     = "rajesh-arigala"
}