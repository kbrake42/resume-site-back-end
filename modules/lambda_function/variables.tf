variable "file_name" {
  type        = string
  description = "The domain name for the website."
}

variable "function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "role" {
  type        = string
  description = "Role the lambda should assume"
}

variable "handler" {
  type        = string
  description = "Lambda handler"
}

variable "runtime" {
  type        = string
  description = "runtime"
}

variable "type" {
  type        = string
  description = "Type of archive file"
}

variable "source_file" {

  type        = string
  description = "Source file for lambda archive"
}

variable "output_path" {

  type        = string
  description = "Output file for lambda archive"
}