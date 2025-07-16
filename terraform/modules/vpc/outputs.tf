output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id

}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id

}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id

}

output "route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_rt.id

}

output "public-rta-id" {
  description = "List of public route table association IDs"
  value       = aws_route_table_association.public-rta[*].id
}
