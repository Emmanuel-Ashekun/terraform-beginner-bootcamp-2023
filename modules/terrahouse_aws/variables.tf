variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "The user_uuid must be a valid UUID format (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}

variable "bucket_name" {
  description = "Name for the AWS S3 bucket"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "Bucket name must be 3-63 characters long and only contain lowercase letters, numbers, hyphens, and periods (dots)."
  }
}

variable "index_html_filepath" {
  type        = string
  description = "Filepath to the index.html file"

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified file does not exist."
  }
}

variable "error_html_filepath" {
  type        = string
  description = "Filepath to the error.html file"

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified file does not exist."
  }
}

variable "content_version" {
  type    = number
  default = 1

  validation {
    condition     = var.content_version > 0 && var.content_version % 1 == 0
    error_message = "Content version must be a positive integer."
  }
}
