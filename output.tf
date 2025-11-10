output "instanc_public_ip" {
  description = "This is the public ip of nginx instance"
  value       = aws_instance.nginx_server.public_ip
}

output "Webserver-URL" {
  description = "this is the url of nginx webserver"
  value       = "http://${aws_instance.nginx_server.public_ip}"
}