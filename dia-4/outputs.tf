output "alb_dns_name" {
  value = module.alb.lb_dns_name
}

output "webserver_instance_id" {
  value = module.webserver.instance_id
}

output "database_instance_id" {
  value = module.database.instance_id
}

output "database_private_ip" {
  value = module.database.private_ip
}

output "webserver_private_ip" {
  value = module.webserver.private_ip
}

