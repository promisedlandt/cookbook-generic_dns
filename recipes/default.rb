include_recipe "generic_dns::#{ node[:generic_dns][:default_dns_provider] }" if node[:generic_dns][:default_dns_provider]
