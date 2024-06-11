variable "name" {
  type = string
  description = "Lamda function name"
}
variable "runtime" {
  description = "Lambda runtmie"
  type        = string
}
variable "entrypoint-file" {
  description = "Path to main file relative to the artifact folder"
  type = string
}
variable "entrypoint-function" {
  description = "Function to call in the entrypoint file"
  type        = string
}
variable "memory" {
  description = "Memory in MB"
  type        = string
}
variable "env" {
  type        = map(string)
  description = "Environment Variables"
}
variable "architecture" {
  type        = string
  description = "CPU architecture x86_64 or arm64"
}
variable "permissions" {
  type        = map(string)
  description = "service with access level read/write"
}
variable "artifacts" {
  type = string
  description = "Path to the folder to zip and deploy to Lambda"
}
variable "timeout" {
  type = string
  description = "Max execution time before aborting"
}
variable "allow-public-access" {
  type = bool
  description = "Generate a public URL. WARNING: ANYONE ON THE INTERNET CAN RUN THIS FUNCTION"
}