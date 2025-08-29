output "vpc_id" {
  value       = aws_vpc.my_vpc.id                                     # The actual value to be outputted
  description = "The public IP address of the EC2 instance" # Description of what this output represents
}
output "my_public_subnet_ids" {
  value = aws_subnet.my_public[*].id
}
output "my_private_subnet_ids" {
  value = aws_subnet.my_private[*].id
}