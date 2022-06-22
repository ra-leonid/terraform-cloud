
output "subnet_id" {
  value       = "${module.vpc.subnet_ids[0]}"
  description = "subnet_id"
}

output "subnet_region" {
  value       = "${var.yc_region}"
  description = "subnet_region"
}

output "service_account_id_news" {
  value       = "${module.news.service_account_id_instance}"
  description = "service_account_id_news"
}

output "internal_ip_address_news" {
  value       = "${module.news.internal_ip_address_instance}"
  description = "internal_ip_address_news"
}

output "external_ip_address_news" {
  value       = "${module.news.external_ip_address_instance}"
  description = "external_ip_address_news"
}
