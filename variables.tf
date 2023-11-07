 variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "The user_uuid must be a valid UUID format (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}