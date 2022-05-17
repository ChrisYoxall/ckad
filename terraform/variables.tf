variable "prefix" {
  description = "Prefix to apply to resources."
  type        = string
  default     = "k8s-test"
}

variable "instances" {
  description = "Number of VMs to create."
  type        = number
  default     = 2
}