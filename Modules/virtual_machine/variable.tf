variable "vm" {
    type = map(any)  
}
variable "ssh_public_key" {
  description = "SSH public key used for VM authentication"
  type        = string
  sensitive   = true
}