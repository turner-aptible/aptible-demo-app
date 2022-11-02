### APTIBLE DEMO APP URL ###

output "aptible_endpoint_url" {
  value = "https://${aptible_endpoint.demo_endpoint.virtual_domain}"
}