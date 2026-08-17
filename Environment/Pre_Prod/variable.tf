variable "rsg" {
  type = map(any)
}
variable "vrnet" {
  type = map(any)
}
variable "snets" {
  type = map(any)
}
variable "puips" {
  type = map(any)
}
variable "vms" {
  type = map(any)
}
variable "netsg" {
  type = map(any)
}
variable "ssh_public_key" {
  description = "SSH public key used for VM authentication"
  type        = string
  sensitive   = true
}